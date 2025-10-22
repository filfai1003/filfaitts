import os
import shutil
import json
import whisper
from datetime import datetime, timezone
import argparse
import sys

class Transcription:
    def __init__(self, id, title, segments, created_at):
        self.id = id
        self.title = title
        self.segments = segments
        self.created_at = created_at

    def toJSON(self):
        return {
            "id": self.id,
            "title": self.title,
            "segments": self.segments,
            "created_at": self.created_at
        }


def transcribe_whisper(audio_path: str, model_name: str = "base") -> dict:
    """Transcribe audio_path with whisper model and return dict with segments.
    This function intentionally does not write any logs or side-effect files.
    """
    if not os.path.isfile(audio_path):
        return {"error": "Audio file not found"}

    if shutil.which("ffmpeg") is None:
        return {"error": "ffmpeg is not installed or not found in PATH"}

    try:
        import torch
        device = "cuda" if torch.cuda.is_available() else "cpu"
        fp16 = device == "cuda"
    except Exception:
        device = "cpu"
        fp16 = False

    try:
        asr = whisper.load_model(model_name)
    except Exception as e:
        return {"error": f"failed to load whisper model '{model_name}': {e}"}

    try:
        # verbose=False to avoid printing/logging
        result = asr.transcribe(
            audio=audio_path,
            verbose=False,
            fp16=fp16,
            language=None,
            condition_on_previous_text=True
        )
    except Exception as e:
        return {"error": f"transcription failed: {e}"}

    output = {
        "text": result.get("text", "").strip(),
        "language": result.get("language"),
        "segments": [
            {
                "startTime": seg.get("start"),
                "endTime": seg.get("end"),
                "content": seg.get("text", "").strip()
            }
            for seg in result.get("segments", [])
        ],
    }
    return output


def create_transcription_file(output_path: str, segments: list) -> None:
    # created_at as timezone-aware ISO string
    now_iso = datetime.now(timezone.utc).isoformat()
    transcription = Transcription(
        id=now_iso,
        title=os.path.splitext(os.path.basename(output_path))[0],
        segments=segments,
        created_at=now_iso
    )
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(json.dumps(transcription.toJSON(), ensure_ascii=False, indent=2))


def main(inputPath, outputPath, model_name: str = "base"):
    # do not print logs during processing; return/exit codes indicate outcome
    if not os.path.isdir(inputPath):
        # silent exit to avoid any console output
        sys.exit(2)
    if not os.path.isdir(outputPath):
        os.makedirs(outputPath, exist_ok=True)

    for filename in os.listdir(inputPath):
        file_path = os.path.join(inputPath, filename)
        if os.path.isfile(file_path):
            base_name = os.path.splitext(filename)[0]
            result = transcribe_whisper(file_path, model_name=model_name)
            if not isinstance(result, dict):
                # skip if unexpected type
                continue
            if result.get("error"):
                # write an error file next to the output JSON so callers can inspect failures
                err_file = os.path.join(outputPath, f"{base_name}.error.json")
                try:
                    with open(err_file, 'w', encoding='utf-8') as ef:
                        json.dump({"error": result.get("error")}, ef, ensure_ascii=False, indent=2)
                except Exception:
                    pass
                # do not remove the original file on error
                continue
            out_file = os.path.join(outputPath, f"{base_name}.json")
            create_transcription_file(out_file, result.get("segments", []))
            try:
                os.remove(file_path)
            except Exception:
                # intentionally silent on removal failures
                pass


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Batch transcribe audio files from an input folder into JSON files in an output folder.")
    parser.add_argument('inputFolder', help='Path to input folder containing audio files')
    parser.add_argument('outputFolder', help='Path to output folder where transcription JSONs will be saved')
    parser.add_argument('--model', '-m', default='base', help='Whisper model name to use (default: base)')
    args = parser.parse_args()
    main(args.inputFolder, args.outputFolder, args.model)
