NAME:=weoptpy
TAG:=first
CMD:=

docker_build:
	docker build -t "${NAME}:${TAG}" --pull .

docker_run:
	docker run --rm --hostname=weoptpy.org -it "${NAME}:${TAG}" "${CMD}"

docker_export:
	docker save -o "${NAME}-${TAG}.tar" ${NAME}:${TAG}

docker_clean:
	docker image rm -f "${NAME}:${TAG}"

singularity_build:
	singularity build --writable "${NAME}-${TAG}.img" Singularity

singularity_import_docker:
	singularity --verbose build "${NAME}-${TAG}.img" "${NAME}-${TAG}.tar"

singularity_shell:
	singularity shell "${NAME}-${TAG}.img"

singularity_run:
	singularity exec "${NAME}-${TAG}.img" "${CMD}"

slurm_run:
	sbatch run.sh
