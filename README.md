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

## Use

To start a transcription, tap the + button at the bottom right.  
(You can also select the model from the dropdown menu above the search bar.)

<img width="1257" height="672" alt="1" src="https://github.com/user-attachments/assets/3962eea4-fcc1-4c51-aa02-555433d606d4" />

Then, choose an audio or video file.

<img width="1172" height="487" alt="2" src="https://github.com/user-attachments/assets/df491475-1eef-438c-a41d-e88428e36b3e" />

Once selected, a loading widget will appear, indicating the initialization and, if necessary, the download of the Whisper model.

<img width="1256" height="668" alt="3" src="https://github.com/user-attachments/assets/48e5105a-ac7e-4e8c-a0ff-971c132bbdcf" />

During the transcription process, you’ll see the title of the current transcription and a progress percentage.

<img width="1256" height="673" alt="4" src="https://github.com/user-attachments/assets/7e678077-3f77-4710-9ef1-6cf0477bf462" />

When it’s complete, all past transcriptions will appear on the home screen, accessible by tapping on them.

<img width="1260" height="676" alt="5" src="https://github.com/user-attachments/assets/7376b891-8ddb-435c-880a-f99555367f09" />

Each transcription offers three display modes, depending on how you intend to use it.

<div style="display: flex; gap: 10px;">
  <img src="https://github.com/user-attachments/assets/80fc5e44-440d-41c2-99f9-0f9403f2199e" alt="6" width="400">
  <img src="https://github.com/user-attachments/assets/992f90dc-3961-49e9-8077-3d903d12ef6a" alt="7" width="400">
  <img src="https://github.com/user-attachments/assets/c17dd84a-93e1-4bc0-9612-cd2980f1ae91" alt="8" width="400">
</div>


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
