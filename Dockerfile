FROM golang:1.22-bullseye as build

WORKDIR /src

# Copy everything but defined in docker ignore file
COPY . .

# Build
# RUN go get github.com/gandarez/redhat-meetup-2024-04-02/db
RUN go mod vendor
RUN make build-linux-amd64

#####################
# Build final image #
#####################
FROM alpine as bin

# Copy from build
COPY --from=build /src/build/video-game-api-linux-amd64 ./video-game-api
COPY db/ db/

# Specify the container's entrypoint as the action
ENTRYPOINT ["./video-game-api"]
