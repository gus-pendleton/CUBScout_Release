# Running Julia multiple times from command line with different threads
for ts in $(seq 1 2 15)
  do
    julia-1.8.5/bin/julia --threads `expr $ts` small_julia.jl
  done
