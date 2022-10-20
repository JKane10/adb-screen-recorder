# adb-screen-recorder
Simple script to record and covert screen recordings on Android to gifs

## **Installation**
This script uses ADB and ffmpeg to convert mp4 files to gifs. ffmpeg can be downloaded via brew
`> $brew install ffmpeg`

## **Usage:**
### **The script has 2 option flags**

### **Quality: -q (optional)**
This determines the quality of the output gif.
- `l` for low (default) - significant resolution and quality changes
- `h` for high - minor resolution and quality changes
- `f` for full -no resolution changes

### **Output: -o (optional)**
This is the name of the output file.
- Current date & time stamp (default value)
- Any string you would want to enter to name the output file.
