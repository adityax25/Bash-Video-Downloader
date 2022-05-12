#!/bin/bash


manual_video () {
		youtube-dl -F $1
		echo "Enter the format code of the video "
		read format
		echo
		read -p "do you want to rename the video ? press y else press n [n]"  choice2
		if [[ $choice2 = "y" ]]; then
			read -p "Enter Name of Video " vidname
			videoname="-o "$vidname."%(ext)s"
		else
			videoname=""
		fi
		echo
		read -p "Do you want to subtitles  press y else press n [n] "  choice3
		if [[ $choice3 = "y" ]]; then
			subs="--write-auto-sub --all-subs --convert-subs srt --embed-subs"
		else
			subs="" 
		fi
		echo
		read -p "Is video hosted on password protected site like instagram, facebook etc. press y else press n [n] "  choice4
		if [[ $choice4 = "y" ]]; then
			read -p "Enter Your Username " user
			read -p "Enter Your Password " -s pass
			userauth="-u "$user
			passauth="-p "$pass
			
		else
			userauth=""
			passauth=""
		fi
		echo
		read -p "is video password protected for sites like vimeo/youku.press y else press n [n] "  choice5
		if [[ $choice5 = "y" ]]; then
			read -p "Enter Video Password " -s passvid
			videopass="--video-password "$passvid
		else
			videopass=""
		fi
		echo
		read -p "Do You want to change format of video.press y else press n [n] "  choice6
		if [[ $choice6 = "y" ]]; then
			read -p "Enter the Video format. (currently supported: mp4|flv|ogg|webm|mkv|avi) " form
			vidform="--recode-video "$form
		else
			vidform=""
		fi
		echo
		read -p "Do you want to Thumbnails  press y else press n [n] "  choice7
		if [[ $choice7 = "y" ]]; then
			thumb="--write-thumbnail --embed-thumbnail"
		else
			thumb="" 
		fi
		youtube-dl -f $format $subs $videoname $userauth $passauth $videopass $thumb $vidform $1
}

manual_audio () {
	echo
		read -p "do you want to rename the audio ? press y else press n [n] "  choice2
		if [[ $choice2 = "y" ]]; then
			read -p "Enter Name of audio " vidname
			videoname="-o "$vidname."%(ext)s"
		else
			videoname=""
		fi
		echo
		read -p "Is audio hosted on password protected site like instagram, facebook etc. press y else press n [n] "  choice4
		if [[ $choice4 = "y" ]]; then
			read -p "Enter Your Username " user
			read -p "Enter Your Password " -s pass
			userauth="-u "$user
			passauth="-p "$pass
			
		else
			userauth=""
			passauth=""
		fi
		echo
		read -p "is video password protected for sites like vimeo/youku? press y else press n [n] "  choice5
		if [[ $choice5 = "y" ]]; then
			read -p "Enter Video Password " -s passvid
			videopass="--video-password "$passvid
		else
			videopass=""
		fi
		echo
		read -p "Do You want to change format of audio; mp3 by default;? press y else press n [n] "  choice6
		if [[ $choice6 = "y" ]]; then
			read -p "Enter the Audio format. Specify audio format: best, aac,flac, mp3, m4a, opus, vorbis,or wav; " form
			vidform="--audio-format "$form
		else
			vidform="--audio-format mp3"
		fi
		echo
		read -p "Do you want to Thumbnails  press y else press n [y] "  choice7
		if [[ $choice7 != "n" ]]; then
			thumb="--write-thumbnail --embed-thumbnail"
		else
			thumb="" 
		fi
		youtube-dl -x -o $videoname $userauth $passauth $videopass $thumb $vidform $1
}

echo Welcome to Video Downloader
echo
echo
echo
echo Your Current Directly is 
pwd
echo
read -p "Do you want to change the directory. press y else press n [n] "  dir_input
if [[  $dir_input = "y" ]]; then
		read -p "Enter the directory location  "  new_dir_inp
		cd $new_dir_inp 
		echo Changed directory is 
		pwd
fi
echo
echo To Download a single video  press 1
echo
echo To Download a videos in batch  press 2
echo
echo To Download as audio press 3
echo
echo To Download audio in batch press 4
echo
echo Enter Your Choice [1]
read choice

if [[ $choice -eq 1 ]]; 
then
	#statements
	echo Enter the url of the video
	read url
	echo
	echo Press 1 for auto mode
	echo
	echo Press 2 for manual mode
	echo
	echo Enter Your Choice [1]
	read choice2
	if [[ $choice2 -eq 1 ]]; then
		youtube-dl --write-auto-sub --all-subs --write-thumbnail --embed-thumbnail --convert-subs srt --embed-subs --recode-video mp4 $url 
		# youtube-dl --recode-video mp4 $url 

	elif [[ $choice2 -eq 2 ]]; then
		manual_video $url
	fi
elif [[ $choice -eq 2 ]];
 then
 	echo Enter the name of the file.
 	echo 
 	echo If file is in another directory then paste the file address
 	read fileaddr
 	filecon=`cat ${fileaddr}`
	echo a new folder will be created for batch downloads
	read -p "Do you want to name this file  press y else press n [n] "  input
	if [[  $input = "y" ]]; then
		read -p "Enter the name of file. Don't include spaces "  new_dir
	else
		new_dir="downloaded-at-"`date +"%d-%m-%y-%T"`
	fi
	mkdir $new_dir
	cd $new_dir
	echo Press 1 for auto mode for all files
	echo
	echo Press 2 for manual mode for all files
	echo
	echo Enter Your Choice [1]
	read choice2
	if [[ $choice2 -eq 1 ]]; then
		for p in $filecon; 
		do
			youtube-dl --write-auto-sub --all-subs --write-thumbnail --embed-thumbnail --convert-subs srt --embed-subs --recode-video mp4 $p
		done
 
	elif [[ $choice2 -eq 2 ]]; then
		for p in $filecon;
		do
  			manual_video $p
		done
	fi
elif [[ $choice -eq 3 ]];
 then
	echo Enter the url of the video
	read url
	echo
	echo Press 1 for auto mode
	echo
	echo Press 2 for manual mode
	echo
	echo Enter Your Choice [1]
	read choice2
	if [[ $choice2 -eq 1 ]]; then
		youtube-dl -x --embed-thumbnail --audio-format mp3 $url 

	elif [[ $choice2 -eq 2 ]]; then
		manual_audio $url
	fi
elif [[ $choice -eq 4 ]]; then
	echo Enter the name of the file.
 	echo 
 	echo If file is in another directory then paste the file address
 	read fileaddr
 	filecon=`cat ${fileaddr}`
	echo a new folder will be created for batch downloads
	read -p "Do you want to name this file  press y else press n [n] "  input
	if [[  $input = "y" ]]; then
		read -p "Enter the name of file. Don't include spaces "  new_dir
	else
		new_dir="downloaded-at-"`date +"%d-%m-%y-%T"`
	fi
	mkdir $new_dir
	cd $new_dir
	echo Press 1 for auto mode for all files
	echo
	echo Press 2 for manual mode for all files
	echo
	echo Enter Your Choice [1]
	read choice2
	if [[ $choice2 -eq 1 ]]; then
		for p in $filecon; 
		do
			youtube-dl -x --embed-thumbnail --audio-format mp3 $p
		done
 
	elif [[ $choice2 -eq 2 ]]; then
		for p in $filecon;
		do
  			manual_audio $p
		done
	fi
fi