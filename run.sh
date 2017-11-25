#!/bin/sh

PBS_O_WORKDIR=/home/kaimo901/test/mpati008

cd $PBS_O_WORKDIR

module purge
module load gcc-4.6.2
module load mvapich2-1.9a2/gnu-4.6.2

mpicc -o mpi_part1 mpi_part1.c -lm
mpicc -o mpi_part2 mpi_part2.c -lm
mpicc -o mpi_part3 mpi_part3.c -lm

jobid=$(qsub job1_1)
j1=$(qsub -W depend=afterany:${jobid} job1_2)
j2=$(qsub -W depend=afterany:${j1} job1_4)
j3=$(qsub -W depend=afterany:${j2} job1_8)

j4=$(qsub -W depend=afterany:${j3} job2_1)
j5=$(qsub -W depend=afterany:${j4} job2_2)
j6=$(qsub -W depend=afterany:${j5} job2_4)
j7=$(qsub -W depend=afterany:${j6} job2_8)

j8=$(qsub -W depend=afterany:${j7} job3_1)
j9=$(qsub -W depend=afterany:${j8} job3_2)
j10=$(qsub -W depend=afterany:${j9} job3_4)
qsub -W depend=afterany:${j10} job3_8

