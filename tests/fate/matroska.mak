FATE_MATROSKA-$(call ALLYES, MATROSKA_DEMUXER ZLIB) += fate-matroska-prores-zlib
fate-matroska-prores-zlib: CMD = framecrc -i $(TARGET_SAMPLES)/mkv/prores_zlib.mkv -c:v copy

# This tests that the matroska demuxer supports modifying the colorspace
# properties in remuxing (-c:v copy)
# It also tests automatic insertion of the vp9_superframe bitstream filter
FATE_MATROSKA-$(call DEMMUX, MATROSKA, MATROSKA) += fate-matroska-remux
fate-matroska-remux: CMD = md5pipe -i $(TARGET_SAMPLES)/vp9-test-vectors/vp90-2-2pass-akiyo.webm -color_trc 4 -c:v copy -fflags +bitexact -strict -2 -f matroska
fate-matroska-remux: CMP = oneline
fate-matroska-remux: REF = e5457e5fa606d564a54914bd12f426c8

FATE_MATROSKA-$(call ALLYES, MATROSKA_DEMUXER VORBIS_PARSER) += fate-matroska-xiph-lacing
fate-matroska-xiph-lacing: CMD = framecrc -i $(TARGET_SAMPLES)/mkv/xiph_lacing.mka -c:a copy

# This tests that the matroska demuxer supports decompressing
# zlib compressed tracks (both the CodecPrivate as well as the actual frames).
FATE_MATROSKA-$(call ALLYES, MATROSKA_DEMUXER ZLIB) += fate-matroska-zlib-decompression
fate-matroska-zlib-decompression: CMD = framecrc -i $(TARGET_SAMPLES)/mkv/subtitle_zlib.mks -c:s copy

FATE_MATROSKA_FFPROBE-$(call ALLYES, MATROSKA_DEMUXER) += fate-matroska-spherical-mono
fate-matroska-spherical-mono: CMD = run ffprobe$(PROGSSUF)$(EXESUF) -show_entries stream_side_data_list -select_streams v -v 0 $(TARGET_SAMPLES)/mkv/spherical.mkv

FATE_SAMPLES_AVCONV += $(FATE_MATROSKA-yes)
FATE_SAMPLES_FFPROBE += $(FATE_MATROSKA_FFPROBE-yes)
