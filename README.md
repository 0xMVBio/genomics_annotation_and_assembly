These are the scripts that were ultimately used for my assembly and assembly-evaluation "pipeline" for one of 69 Arabidopsis thaliana accessions from the following nature paper: 
https://www.nature.com/articles/s41588-024-01715-9

My accession number was Kyr-01
The scripts were used in the following order and are located under genomics_annotation_and_assembly/scripts    
The output and error log files of my runs are under genomics_annotation_and_assembly/output_and_errors

the actual output files are on the cluster under:
FOR FASTQC: /data/users/mvaldivia/genome_assembly_course/outputs
FOR ASSEMBLIES: /data/users/mvaldivia/genome_assembly_course/assemblies
FOR EVALS: /data/users/mvaldivia/genome_assembly_course/evaluation


The Run/Pipeline for my accession:
1 . Assemblies and preprocess: 
    In Order: genomics_annotation_and_assembly/scripts
    /assembly_and_preprocess

2. Evals: 
   In Order: genomics_annotation_and_assemblyscripts/evals
   But 06_merqury_w_forloop.sh (FAILED after database creation, as to be seen in: merqury_all_19322101.err)
   so I ran    06_merqury_eval.sh separately

