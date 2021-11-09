# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b elle -g default,-mips,-darwin,-notdefault
git clone https://github.com/WalkingProjekt-juice/manifest.git --depth 1 -b EvoX .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build ro
source build/envsetup.sh
lunch evolution_juice-userdebug
export TZ=Europe/Samara
export KBUILD_BUILD_USER=WalkingDead
export KBUILD_BUILD_HOST=WalkingCI
make evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
