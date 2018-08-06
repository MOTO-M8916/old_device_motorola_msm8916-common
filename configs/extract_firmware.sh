#!/sbin/sh

for file in /firmware/image/*.gz; do
  OUT_FILE=$(basename $file .gz)
  gzip -dc $file > /vendor/firmware/$OUT_FILE
  chmod 644 /vendor/firmware/$OUT_FILE
  chcon u:object_r:firmware_file:s0 /vendor/firmware/$OUT_FILE
  chmod 644 "/system/build.prop"
  chmod 644 "/vendor/build.prop"
done
