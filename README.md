# 🗣️ FilfaiSTT

**FilfaiSTT** is a personal demo app for **unlimited local transcription** of audio and video files.  
It runs entirely **offline**, using speech-to-text models (e.g., Whisper) without time limits or API costs.

---

## ⚙️ Main Features

- 🎧 Transcribes **audio and video** files into text  
- 💻 Works **fully locally** — no uploads or internet required  
- 📜 Handles **unlimited-length** transcriptions  

---

## 🧠 Requirements

- **Desktop environment**: Windows, Linux, or macOS  
- **FFmpeg** installed and available in your system PATH  

---

## 🚀 Installation & Run

1. Download the release archive and extract it inside the `./release/` folder:  

./release/filfaistt_win_0.1.zip


2. Run the executable:  

filfaitts.exe


3. Make sure **FFmpeg** is installed:  
```bash
ffmpeg -version
```
If it’s not found, install it from https://ffmpeg.org/download.html.

---

## 🧩 Technical Notes

  The source code does not include the linux/, windows/, or macos/ build folders,
  as they were omitted to save repository space on GitHub (100 MB limit).

  These folders can be easily regenerated using Flutter with a single command:

```bash
  flutter create .
```

---
  
## 📄 License

This project includes files and libraries released under the MIT License (e.g., OpenAI Whisper).  
The official license can be found at `./assets/LICENSE_whisper `.  
