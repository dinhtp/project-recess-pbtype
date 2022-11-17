set -e

SRC=$GOPATH/src
# Generate protobufs types all the dir. Exclude hidden directories such as .git
shopt -u dotglob
find * -prune -type d -type d ! -name webhook | while read -r d; do
  protoc -I/usr/local/include -I. \
    -I${SRC} \
    -I${SRC}/github.com/grpc-ecosystem/grpc-gateway \
    -I${SRC}/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
    --go_out=${SRC} \
    --go-grpc_out=require_unimplemented_servers=false:${SRC} \
    --grpc-gateway_out=logtostderr=true:${SRC} \
    --swagger_out=logtostderr=true:${SRC}/github.com/dinhtp/project-recess-pbtype \
    ${d}/*.proto
done