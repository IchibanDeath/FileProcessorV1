# FileProcessorV1

This is a PowerShell script I developed to automate one of the only mundane and repetative tasks at my place of employment.

I will do my best to comment out what each section does, and my plan is once this is done to create other versions of this for other similar tasks, and hopefully recreate it in Python so I can learn some of that language.

This script was designed to take files that always have a similar naming structure [In this case "MMDDYYYYHHMMSS_OtherDataHere.mp3"] and make reading/storing them more user friendly by making them fit in to this structure ["Whatever MM-DD-YYYY.mp3"]

The hardest part to learn (As I'm still stuck on it as of now) was if there were more than one file created on the same day, how to recursively step up the files, and instead of using an integer or random number, have it count up by a, b, c, ~ .