SOURCE="${BASH_SOURCE[0]}"
echo $SOURCE
DIR="$( dirname "$SOURCE" )"
cd $DIR/..

echo "Building patient-api .... "
docker build -t dfpatient . && \

cd docker/patientpostgres && \
echo "Building latest persistence image..." && \
docker build -t patientpostgres .
