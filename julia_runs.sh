# Running Julia multiple times from command line with different threads
for ts in $(seq 1 2 7)
  do
    /Applications/Julia-1.8.app/Contents/Resources/julia/bin/julia --threads `expr $ts` small_julia.jl
  done
