-- database name: "rna_expression"
-- schema name: "blueprint"

CREATE UNLOGGED TABLE transit_tmp(
  data_row TEXT
);
COMMENT ON TABLE transit_tmp IS 'Staging table for loading data into database. Data is transferred from here into target tables by parsing the values in this table''s single column';

CREATE TABLE blueprint.e_mtab_3827_query_result(
  Gene_ID TEXT PRIMARY KEY,
  Gene_Name TEXT,
  CD14_pos_CD16_negative_classical_monocyte REAL,
  macrophage REAL,
  inflammatory_macrophage REAL,
  conventional_dendritic_cell REAL,
  CD4_pos_alpha_beta_thymocyte REAL,
  CD8_pos_alpha_beta_thymocyte REAL,
  CD3_pos_CD4_pos_CD8_pos_double_pos_thymocyte REAL,
  CD38_negative_naive_B_cell REAL,
  memory_B_cell REAL,
  class_switched_memory_B_cell REAL,
  CD4_pos_alpha_beta_T_cell REAL,
  CD8_pos_alpha_beta_T_cell REAL,
  alternatively_activated_macrophage REAL,
  central_memory_CD4_pos_alpha_beta_T_cell REAL,
  effector_memory_CD4_pos_alpha_beta_T_cell REAL,
  central_memory_CD8_pos_alpha_beta_T_cell REAL,
  effector_memory_CD8_pos_alpha_beta_T_cell REAL,
  regulatory_T_cell REAL,
  cytotoxic_CD56_dim_natural_killer_cell REAL,
  erythroblast REAL,
  CD34_negative_CD41_pos_CD42_pos_megakaryocyte_cell REAL,
  mature_eosinophil REAL,
  mature_neutrophil REAL,
  segmented_neutrophil_of_bone_marrow REAL,
  neutrophilic_metamyelocyte REAL,
  endothelial_cell_of_umbilical_vein_proliferating REAL,
  endothelial_cell_of_umbilical_vein_resting REAL);
 COMMENT ON TABLE blueprint.e_mtab_3827_query_result IS
 $qq$
 Data source: Expression Atlas, link https://www.ebi.ac.uk/gxa/experiments/E-MTAB-3827/Results
 Source file metadata:
 # Expression Atlas
# Query: Genes matching: 'default query', specifically expressed above the expression level cutoff: 0.5 TPM in experiment E-MTAB-3827
# Selected columns: 27 (all)
# Timestamp: Wed, 06-Dec-2017 10:05:49
 $qq$

INSERT INTO blueprint.e_mtab_3827_query_result(
	gene_id, gene_name, cd14_pos_cd16_negative_classical_monocyte, macrophage, inflammatory_macrophage, conventional_dendritic_cell, cd4_pos_alpha_beta_thymocyte, 
    cd8_pos_alpha_beta_thymocyte, cd3_pos_cd4_pos_cd8_pos_double_pos_thymocyte, cd38_negative_naive_b_cell, memory_b_cell, class_switched_memory_b_cell, 
    cd4_pos_alpha_beta_t_cell, cd8_pos_alpha_beta_t_cell, alternatively_activated_macrophage, central_memory_cd4_pos_alpha_beta_t_cell, 
    effector_memory_cd4_pos_alpha_beta_t_cell, central_memory_cd8_pos_alpha_beta_t_cell, effector_memory_cd8_pos_alpha_beta_t_cell, regulatory_t_cell, 
    cytotoxic_cd56_dim_natural_killer_cell, erythroblast, cd34_negative_cd41_pos_cd42_pos_megakaryocyte_cell, mature_eosinophil, mature_neutrophil, 
    segmented_neutrophil_of_bone_marrow, neutrophilic_metamyelocyte, endothelial_cell_of_umbilical_vein_proliferating, endothelial_cell_of_umbilical_vein_resting)
SELECT
   (STRING_TO_ARRAY(data_row, E'\t'))[1],
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[2], ''),
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[3], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[4], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[5], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[6], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[7], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[8], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[9], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[10], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[11], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[12], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[13], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[14], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[15], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[16], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[17], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[18], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[19], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[20], '')::REAL, 
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[21], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[22], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[23], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[24], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[25], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[26], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[27], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[28], '')::REAL,
   NULLIF((STRING_TO_ARRAY(data_row, E'\t'))[29], '')::REAL
FROM
  transit_tmp;

CREATE OR REPLACE VIEW blueprint.vw_macrophage_differential_gene_expression AS
SELECT
  gene_id,
  gene_name,
  macrophage_type_expr_total,
  non_macrophage_type_expr_total,
  macrophage_type_expr_total/non_macrophage_type_expr_total macrophage_non_macrophage_expr_total_ratio
FROM
  (SELECT
    gene_id,
    gene_name,
    COALESCE(macrophage, 0.0) + COALESCE(inflammatory_macrophage, 0.0) + COALESCE(alternatively_activated_macrophage, 0) macrophage_type_expr_total,
    COALESCE(CD14_pos_CD16_negative_classical_monocyte, 0.0)+ COALESCE(conventional_dendritic_cell, 0.0)+ COALESCE(CD4_pos_alpha_beta_thymocyte, 0.0)
    + COALESCE(CD8_pos_alpha_beta_thymocyte, 0.0)+ COALESCE(CD3_pos_CD4_pos_CD8_pos_double_pos_thymocyte, 0.0)+ COALESCE(CD38_negative_naive_B_cell, 0.0)
    + COALESCE(memory_B_cell, 0.0)+ COALESCE(class_switched_memory_B_cell, 0.0)+ COALESCE(CD4_pos_alpha_beta_T_cell, 0.0)+ COALESCE(CD8_pos_alpha_beta_T_cell, 0.0)
    + COALESCE(central_memory_CD4_pos_alpha_beta_T_cell, 0.0)+ COALESCE(effector_memory_CD4_pos_alpha_beta_T_cell, 0.0)
    + COALESCE(central_memory_CD8_pos_alpha_beta_T_cell, 0.0)+ COALESCE(effector_memory_CD8_pos_alpha_beta_T_cell, 0.0)+ COALESCE(regulatory_T_cell, 0.0)
    + COALESCE(cytotoxic_CD56_dim_natural_killer_cell, 0.0)+ COALESCE(erythroblast, 0.0)+ COALESCE(CD34_negative_CD41_pos_CD42_pos_megakaryocyte_cell, 0.0)
    + COALESCE(mature_eosinophil, 0.0)+ COALESCE(mature_neutrophil, 0.0)+ COALESCE(segmented_neutrophil_of_bone_marrow, 0.0)+ COALESCE(neutrophilic_metamyelocyte, 0.0)
    + COALESCE(endothelial_cell_of_umbilical_vein_proliferating, 0.0)+ COALESCE(endothelial_cell_of_umbilical_vein_resting, 0.0) non_macrophage_type_expr_total
  FROM
    blueprint.e_mtab_3827_query_result) sq
WHERE
  non_macrophage_type_expr_total > 0
ORDER BY 5 DESC;
COMMENT ON VIEW blueprint.vw_macrophage_differential_gene_expression IS 'Contains an estimation of how much a gene is differentially expressed in macrophages compared to all the other cell types. A ratio is calculated that is highest for genes showing differential expression in macrophages';
 
