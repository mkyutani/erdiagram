#!/usr/bin/env bash
## -*- mode: shell-script -*-

PROGNAME=$(basename $0)
DIRNAME=$(dirname $0)
VERSION="1"

CONTAINER="eralchemy"
IMAGE="eralchemy"
OUTPUT_DIR="./tmp"

PROTOCOL="postgresql"
SERVER="localhost"
PORT=""
DATABASE="postgres"
USER="$(id -un)"
PASSWORD=""
NETWORK="default"
OUTPUT_FILE="er.png"

usage() {
    echo "Usage: ${PROGNAME} [OPTIONS]"
    echo
    echo "Options:"
    echo
    echo "  -h, --help                  help"
    echo "  -d, --database DATABASE     database name (default: \"${DATABASE}\")"
    echo "  -D, --dir DIRECTORY         directory (default: \"${OUTPUT_DIR}\")"
    echo "  -n, --network NETWORK       container network (default: \"${NETWORK}\")"
    echo "  -o, --output FILE           output file name (default: \"${OUTPUT_FILE}\")"
    echo "  -p, --password PASSWORD     database password (default: None)"
    echo "  -P, --port PORT             database server port (default: None)"
    echo "      --protocol NAME         database protocol (default: \"${PROTOCOL}\")"
    echo "  -s, --server SERVER         database server (default: \"${SERVER}\")"
    echo "  -u, --user USER             database user (default: \"${USER}\")"
    echo
    exit 1
}

for OPT in "$@"
do
    case "$OPT" in
        '-h' | '--help' )
            usage
            ;;
        '--protocol' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "${PROGNAME}: option requires an argument -- $1" 1>&2
                exit 1
            fi
            PROTOCOL="$2"
            shift 2
            ;;
        '-s' | '--server' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "${PROGNAME}: option requires an argument -- $1" 1>&2
                exit 1
            fi
            SERVER="$2"
            shift 2
            ;;
        '-P' | '--port' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "${PROGNAME}: option requires an argument -- $1" 1>&2
                exit 1
            fi
            PORT=":$2"
            shift 2
            ;;
        '-d' | '--database' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "${PROGNAME}: option requires an argument -- $1" 1>&2
                exit 1
            fi
            DATABASE="$2"
            shift 2
            ;;
        '-u' | '--user' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "${PROGNAME}: option requires an argument -- $1" 1>&2
                exit 1
            fi
            USER="$2"
            shift 2
            ;;
        '-p' | '--password' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "${PROGNAME}: option requires an argument -- $1" 1>&2
                exit 1
            fi
            PASSWORD=":$2"
            shift 2
            ;;
        '-n' | '--network' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "${PROGNAME}: option requires an argument -- $1" 1>&2
                exit 1
            fi
            NETWORK="$2"
            shift 2
            ;;
        '-o' | '--output' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "${PROGNAME}: option requires an argument -- $1" 1>&2
                exit 1
            fi
            OUTPUT_FILE="$2"
            shift 2
            ;;
        -*)
            echo "${PROGNAME}: illegal option -- '$(echo $1 | sed 's/^-*//')'" 1>&2
            exit 1
            ;;
    esac
done

CONN="${PROTOCOL}://${USER}${PASSWORD}@${SERVER}${PORT}/${DATABASE}"
VOLUME=$(readlink -f ${OUTPUT_DIR})

mkdir -p ${VOLUME}

# Execute ERAlchemy
docker run --name ${CONTAINER} -d --network ${NETWORK} --volume ${VOLUME}:/output ${IMAGE} -i ${CONN} -o /output/${OUTPUT_FILE}

# Print execution log
docker logs ${CONTAINER}

# Finish
NOT_REMOVED="1"
while [[ ${NOT_REMOVED} = "1" ]]
do
    sleep 1
    echo -n "Removing " && docker rm ${CONTAINER}
    NOT_REMOVED=$?
done
