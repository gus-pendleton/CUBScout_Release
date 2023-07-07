# Class example for MILC estimation
library(purrr)
library(Biostrings)
library(coRdon)
full_milc = function(filepaths){
  map(filepaths,
      \(x)readDNAStringSet(file = x)|>
        codonTable()|>
        MILC(alt.init = FALSE, stop.rm = FALSE, filtering = "none"))
}
full_enc = function(filepaths){
  map(filepaths,
      \(x)readDNAStringSet(file = x)|>
        codonTable()|>
        ENC(alt.init = FALSE, stop.rm = FALSE, filtering = "none"))
}

full_everything = function(filepaths){
  dna = map(filepaths,
            \(x)readDNAStringSet(file = x))
  codon_tables = map(dna, .progress = TRUE,
                     \(x)codonTable(x))
  
  b = map(codon_tables, \(x)B(x, alt.init = FALSE, stop.rm = FALSE, filtering = "hard"))
  e = map(codon_tables, \(x)ENC(x, alt.init = FALSE, stop.rm = FALSE, filtering = "hard"))
  ep = map(codon_tables, \(x)ENCprime(x, alt.init = FALSE, stop.rm = FALSE, filtering = "hard"))
  mc = map(codon_tables, \(x)MCB(x, alt.init = FALSE, stop.rm = FALSE, filtering = "hard"))
  mi = map(codon_tables, \(x)MILC(x, alt.init = FALSE, stop.rm = FALSE, filtering = "hard"))
  s = map(codon_tables, \(x)SCUO(x, alt.init = FALSE, stop.rm = FALSE, filtering = "hard"))
  
  return(list(b, e, ep, mc, mi, s))
}

files = list.files("./CUBScout_Release/renamed_genomes", pattern = "*.fna", full.names = TRUE)

milc_time = system.time(full_milc(files))
enc_time = system.time(full_enc(files))
all_time = system.time(full_everything(files))

write.csv(c(milc_time, enc_time, all_time), file = "r_results.csv")



