echo "Starting build"

mkdir /tmp/build

cp -r /source/* /tmp/build/

cd /tmp/build

cactus build

rm -rf /tmp/build/.build/static

cp -rf /tmp/build/static /tmp/build/.build

chmod -R ugo+rx /tmp/build/.build/static

cp -r /tmp/build/.build/* /usr/share/nginx/html

echo "Build completed"
