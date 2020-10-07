# Exemple abbaye Bonrepos : data=".*JPG" out_name="F03"

data=$1
out_name=$2

# Calcul points de liaison
mm3d Tapioca MulScale $data 500 1200
# Callibration, étalonnage, i.e. détermination paramètres distorsion
mm3d Tapas RadialStd $data Out=$out_name 
mm3d AperiCloud $data Ori-$out_name
mm3d C3DC MicMac $data $out_name 
