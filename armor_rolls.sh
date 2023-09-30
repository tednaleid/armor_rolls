#! /usr/bin/env bash

set -euo pipefail
# this script determines the chances to roll a specific destiny armor roll

# destiny armor rolls are determined by the following:
# 1. destiny armor has 6 stats: mobility, resilience, recovery, discipline, intellect, strength
# 2. these stats come in 2 groups
#   a. group 1 is mobility, resilience, recovery
#   b. group 2 is discipline, intellect, strength
# 3. There is a set of "plugs" that can be inserted in armor
# 4. Each plug has a set of stats associated with it, and each plug belongs to either group 1 or group 2
# 5. Each piece of armor randomly selects 2 plugs from each group


if [[ $# -ne 6 ]]; then
  echo "Usage: $0 mobility resilience recovery discipline intellect strength" >&2
  exit 1
fi

mobility=$1
resilience=$2
recovery=$3
discipline=$4
intellect=$5
strength=$6

# taken from https://www.reddit.com/r/DestinyTheGame/comments/mpaopq/how_armor_stats_roll_an_advanced_insight_into/
# plug hash, mobility, resilience, recovery, discipline, intellect, strength, total
plugs="\
1232924472	1	5	5				11
3816367703	1	5	5				11
2120002858	5	5	1				11
2191854732	5	1	5				11
3135249387	5	1	5				11
3912049957	5	5	1				11
1177742666				1	5	5	11
4085212425				1	5	5	11
91007917				5	5	1	11
929438819				5	1	5	11
1322519294				5	5	1	11
4237052128				5	1	5	11
479726201	1	10	1				12
1144611477	1	5	6				12
2537136913	1	1	10				12
3533158667	1	6	5				12
356817849	5	6	1				12
2283579401	5	1	6				12
751095403	6	1	5				12
1527895973	6	5	1				12
3407231789	10	1	1				12
795935713				1	5	6	12
1520468795				1	1	10	12
2261191075				1	6	5	12
3468066869				1	10	1	12
3690940823				5	6	1	12
4222896411				5	1	6	12
1749177701				6	5	1	12
3129612155				6	1	5	12
67755179				10	1	1	12
181487579	1	6	6				13
969663972	1	11	1				13
1270499666	1	1	11				13
1271535931	1	5	7				13
1353822395	1	7	5				13
1355919655	1	7	5				13
2576224072	1	1	11				13
3026591432	1	11	1				13
3161349231	1	6	6				13
3504220063	1	5	7				13
1312790983	5	1	7				13
2518640481	5	7	1				13
3416808229	5	7	1				13
3898228147	5	1	7				13
1260850215	6	1	6				13
1534361879	6	6	1				13
3732179899	6	6	1				13
3758749131	6	1	6				13
462858415	7	1	5				13
534710281	7	5	1				13
2600754315	7	1	5				13
3324262725	7	5	1				13
2236091344	11	1	1				13
4179385676	11	1	1				13
32051168				1	11	1	13
1277668557				1	7	5	13
1427308465				1	7	5	13
1928834709				1	6	6	13
2547068585				1	6	6	13
2819908046				1	1	11	13
2949460770				1	1	11	13
3078811914				1	11	1	13
3514882373				1	5	7	13
4083070345				1	5	7	13
1219232383				5	1	7	13
2596709069				5	7	1	13
2851176171				5	1	7	13
4054265521				5	7	1	13
77849045				6	6	1	13
2683277641				6	6	1	13
3354229341				6	1	6	13
3804506889				6	1	6	13
2918883917				7	5	1	13
3014984195				7	1	5	13
3692191479				7	1	5	13
4195038769				7	5	1	13
757147114				11	1	1	13
3393081898				11	1	1	13
442806465	1	5	8				14
806640977	1	7	6				14
1087657324	1	12	1				14
1232201448	1	1	12				14
1408072829	1	8	5				14
1753812297	1	6	7				14
1773410855	1	8	5				14
1798836563	1	6	7				14
1973376392	1	12	1				14
2407887271	1	5	8				14
2870662108	1	1	12				14
3426919231	1	7	6				14
314704911	5	1	8				14
333640025	5	8	1				14
3159833103	5	8	1				14
3420580409	5	1	8				14
141714163	6	1	7				14
236547055	6	7	1				14
803538505	6	1	7				14
4223985057	6	7	1				14
176934377	7	1	6				14
622142895	7	1	6				14
2532652671	7	6	1				14
2545139993	7	6	1				14
1217350407	8	5	1				14
1539937265	8	5	1				14
2157550925	8	1	5				14
2173375639	8	1	5				14
902238168	12	1	1				14
2009456796	12	1	1				14
204379057				1	7	6	14
303737906				1	1	12	14
625442459				1	6	7	14
638918212				1	12	1	14
729228807				1	5	8	14
2004812199				1	7	6	14
2230385985				1	5	8	14
2261839061				1	8	5	14
2500662503				1	8	5	14
3060956649				1	6	7	14
3076594222				1	1	12	14
3526144456				1	12	1	14
1244639311				5	8	1	14
2132812461				5	1	8	14
2807591295				5	1	8	14
3700987149				5	8	1	14
417861857				6	1	7	14
1738627851				6	7	1	14
3272284147				6	1	7	14
4123154229				6	7	1	14
901009259				7	1	6	14
970151529				7	1	6	14
1909626293				7	6	1	14
4251278951				7	6	1	14
175447717				8	1	5	14
1001412103				8	5	1	14
2417261591				8	1	5	14
3332954065				8	5	1	14
3378410678				12	1	1	14
4256224050				12	1	1	14
1157098101	1	5	9				15
1223091094	1	1	13				15
1303354444	1	1	13				15
1354491810	1	13	1				15
1369119565	1	7	7				15
1858911761	1	8	6				15
1997804225	1	6	8				15
2977126596	1	13	1				15
3148433189	1	9	5				15
128416290	5	5	5				15
1533918171	5	9	1				15
2373945819	5	5	5				15
3554741641	5	1	9				15
2433764085	6	1	8				15
4002613733	6	8	1				15
3198072315	7	7	1				15
3528720645	7	1	7				15
2440285137	8	6	1				15
3027133505	8	1	6				15
1526511067	9	5	1				15
3498780609	9	1	5				15
187944698	13	1	1				15
3969669620	13	1	1				15
73015				1	9	5	15
597281635				1	8	6	15
1553920866				1	1	13	15
2084652226				1	13	1	15
2190013560				1	1	13	15
2329681032				1	13	1	15
2417304911				1	6	8	15
3045360783				1	5	9	15
3203727595				1	7	7	15
992788499				5	9	1	15
1807139373				5	5	5	15
2692705068				5	5	5	15
3763271097				5	1	9	15
1259855003				6	8	1	15
3992556923				6	1	8	15
1881464983				7	7	1	15
3882993517				7	1	7	15
706559219				8	1	6	15
975449263				8	6	1	15
2867247961				9	1	5	15
3976251931				9	5	1	15
534307848				13	1	1	15
1090584498				13	1	1	15
229383925	1	10	5				16
690823209	1	5	10				16
1328546174	1	14	1				16
1656082061	1	6	9				16
2116352646	1	7	8				16
2581052211	1	7	8				16
2868325782	1	9	6				16
3198618292	1	6	9				16
3379686671	1	9	6				16
3942888333	1	8	7				16
4084541802	1	1	14				16
4228095872	1	8	7				16
29254703	5	10	1				16
1916824087	5	1	10				16
643846500	6	1	9				16
1476255565	6	1	9				16
2387165386	6	9	1				16
3581342943	6	9	1				16
1087628722	7	8	1				16
2411971911	7	1	8				16
3072193746	7	1	8				16
3861914183	7	8	1				16
261789293	8	1	7				16
2003042147	8	7	1				16
2769650464	8	1	7				16
3915102502	8	7	1				16
772656086	9	6	1				16
2229578547	9	6	1				16
2287381891	9	1	6				16
3346214146	9	1	6				16
1500306577	10	5	1				16
1815871927	10	1	5				16
2978558314	14	1	1				16
594234536				1	8	7	16
963778029				1	8	7	16
1281522919				1	7	8	16
1370127613				1	6	9	16
1561576321				1	10	5	16
2251614419				1	5	10	16
2268589328				1	1	14	16
3101883988				1	6	9	16
3362988962				1	7	8	16
3769441714				1	9	6	16
3789172379				1	9	6	16
4073867034				1	14	1	16
1407962355				5	10	1	16
3350537281				5	1	10	16
134899365				6	1	9	16
1284869343				6	9	1	16
1300719726				6	9	1	16
3341858112				6	1	9	16
2303800333				7	1	8	16
2601796280				7	1	8	16
3475114824				7	8	1	16
4284717165				7	8	1	16
1137441703				8	7	1	16
1972078973				8	1	7	16
2955637074				8	7	1	16
3026009912				8	1	7	16
1570603856				9	6	1	16
2158218481				9	6	1	16
3431456944				9	1	6	16
3945536197				9	1	6	16
2607035717				10	5	1	16
3987470171				10	1	5	16
1770080868				14	1	1	16
990136527	1	1	15				17
1429795213	1	15	1				17
1835957490	1	15	1				17
2148570570	1	11	5				17
3159532540	1	1	15				17
4248662490	1	5	11				17
1281324436	5	1	11				17
2399358832	5	11	1				17
2600679334	11	5	1				17
3955940376	11	1	5				17
1390278942	15	1	1				17
4286256569	15	1	1				17
115819390				1	11	5	17
2877222076				1	15	1	17
2909952716				1	1	15	17
2931229360				1	5	11	17
4184353495				1	1	15	17
4206284259				1	15	1	17
792638842				5	1	11	17
2664898188				5	11	1	17
2264557658				11	5	1	17
2701881372				11	1	5	17
166910052				15	1	1	17
3017869859				15	1	1	17"

# we read the plugs into group 1 and group 2 associative arrays
# then we create the combinations for each group of all 2 plug combinations
# then we see how many combinations have the stats that were given by the user
# and comapre that to the total number of possible combinations
echo "$plugs" | gawk -F'\t' -v mobility="$mobility" \
    -v resilience="$resilience" \
    -v recovery="$recovery" \
    -v discipline="$discipline" \
    -v intellect="$intellect" \
    -v strength="$strength" \
    '
    # group 1 is mobility, resilience, recovery = total
    # we take 2 plugs from each group, and no plug value is < 1 so we only keep plugs that could be used
    $2 > 0 && $2 < mobility && $3 < resilience && $4 < recovery && $8 <= mobility + resilience + recovery - 11 {
      group1[$1] = $2","$3","$4
      # print "mrr NF: " NF, $0
      next
    }

    $5 < discipline && $6 < intellect && $7 < strength && $8 <= discipline + intellect + strength - 11 { 
      group2[$1] = $5","$6","$7
      # print "dis NF: " NF, $0
    }

    function find_valid_plug_combos(plug_group, stat1, stat2, stat3,        indices, i, j, plug1, plug1parts, plug2, plug2parts) {
      num = asorti(plug_group, indices)
      for (i=1; i<num; i++) {
        plug1 = plug_group[indices[i]]
        split(plug1, plug1parts, ",")
        for (j=i+1; j<=num; j++) {
          plug2 = plug_group[indices[j]]
          split(plug2, plug2parts, ",")
          # print indices[i], plug1, indices[j], plug2
          if (plug1parts[1] + plug2parts[1] == stat1 && plug1parts[2] + plug2parts[2] == stat2 && plug1parts[3] + plug2parts[3] == stat3) {
            print indices[i], plug1, indices[j], plug2
          }
        }
      }

    }
    END {
      print "valid plug combinations for mobility, resilience, recovery"
      find_valid_plug_combos(group1, mobility, resilience, recovery)

      print "valid plug combinations for discipline, intellect, strength"
      find_valid_plug_combos(group2, discipline, intellect, strength)
    }
    '

# total mob/res/rec combinations
# 88 * 87 = 7,656

# total dis/int/str combinations
# 88 * 87 = 7,656

# total combinations for mob/res/rec and dis/int/str 58,614,336 (7,656 * 7,656) 