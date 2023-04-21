#GO annotation file for TopGO
grep -h "GO:" All_Accessory_interpro.tsv Core_interpro.tsv | sed 's/|/,/g' | awk -F "\t" '{print $1"\t"$NF}' | uniq | awk 'BEGIN{FS="\t"; OFS=FS}; { arr[$1] = arr[$1] == ""? $2 : arr[$1] "," $2 } END {for (i in arr) print i, arr[i] }' > Pooled_gene2GO.tsv

#Present/Absent matrix for UpSetR:
#First the sample names were used to make column headers
#Then the Orthofinder orthogroups table was converted to a matrix by replacing empty columns with '0' and columns containing gene names with '1' 
echo "HOG	OG	KE.KAK.344	KE.KER.468	KE.KER.511	KE.KIS.232	KE.KIT.758	KE.SIA.288	KE.TRS.520	UG.FTP.009	UG.GYZ.032	UG.KPC.038	UG.LIR.101	UG.MSK.001	UG.NML.092	ZA.BZN.007	ZA.BZN.009	ZA.CED.V02.124	ZA.CED.V05.074	ZA.CRG.097	ZA.EST.017	ZA.NTB.069	ZA.NXM.079	ZM.CHS.019	ZM.CHS.045	ZM.CHS.092	ZW.AFR.270	ZW.ART.151	ZW.CHN.315	ZW.CMH.326	ZW.RRS.263	ZW.STP.133	CMW25467" > UpSet_input.tsv

sed '1d' Phylogenetic_Hierarchical_Orthogroups/N0.tsv | awk -F "\t" '{printf "%s",$1"\t"$2"\t"}{for (i=4; i<=33; i++) if($i == "") printf "%s",0"\t"; else printf "%s",1"\t"}{if($NF == "\r") print 0; else print 1}' >> UpSet_input.tsv
