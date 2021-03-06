#!/bin/bash

WORKDIR=nsmb.d
DOL=${WORKDIR}/sys/main.dol
DOWNLOAD_LINK="https://www.dropbox.com/s/f7x8evfrc07bcbw/NSMBW%203%20The%20Final%20Levels.zip"
RIIVOLUTION_ZIP="NSMBW3_The final levels.zip"
RIIVOLUTION_DIR="NSMBW3"
GAMENAME="NSMBW3: The Final Levels"
XML_SOURCE="${RIIVOLUTION_DIR}"
XML_FILE="${RIIVOLUTION_DIR}"/../riivolution/NSMBW3.XML
GAME_TYPE=RIIVOLUTION
BANNER_LOCATION=${WORKDIR}/files/opening.bnr
WBFS_MASK="SMN[PEJ]01"

show_notes () {

echo -e \
"************************************************
${GAMENAME}

NSMBW Hack featuring a bunch of new levels.

Source:			http://www.rvlution.net/forums/viewtopic.php?f=53&t=1673
Base Image:		New Super Mario Bros. Wii (SMN?01)
Supported Versions:	EURv1, EURv2, USAv1, USAv2, JPNv1
************************************************"

}

detect_game_version () {

	nsmbw_version

	GAMEID=SFL${REG_LETTER}01
	if [[ ${VERSION} != EURv* ]]; then
		echo -e "Versions other than PAL won't show the correct title-screen."
	fi

}

place_files () {

	NEW_DIRS=( "${WORKDIR}"/files/EU/NedEU/{Message,Layout} )
	for dir in "${NEW_DIRS[@]}"; do
		mkdir -p "${dir}"
	done

	case ${VERSION} in
		EUR* )
			LANGDIRS=( EngEU FraEU GerEU ItaEU SpaEU NedEU )
			for dir in "${LANGDIRS[@]}"; do
				cp -r "${RIIVOLUTION_DIR}"/EU/EngEU/Message "${WORKDIR}"/files/EU/"${dir}"/
			done
			cp "${RIIVOLUTION_DIR}"/EU/Layout/openingtitle/* "${WORKDIR}"/files/EU/Layout/openingTitle/openingTitle.arc
		;;

		USAv* )
			LANGDIRS=( FraUS EngUS SpaUS )
			for dir in "${LANGDIRS[@]}"; do
				cp -r "${RIIVOLUTION_DIR}"/EU/EngEU/Message "${WORKDIR}"/files/US/"${dir}"/
			done
		;;

		JPNv1 )
			cp -r "${RIIVOLUTION_DIR}"/EU/EngEU/Message "${WORKDIR}"/files/JP/
		;;
	esac

	cp -r "${RIIVOLUTION_DIR}"/Stage/ "${WORKDIR}"/files/

}


dolpatch () {

	${WIT} dolpatch ${DOL}	\
		"802F148C=53756D6D53756E#7769696D6A3264" \
		"802F118C=53756D6D53756E#7769696D6A3264" \
		"802F0F8C=53756D6D53756E#7769696D6A3264" \
		xml="${PATCHIMAGE_PATCH_DIR}/NSMBW_AP.xml" -q

}

