using CUBScout
using Glob

threads = Threads.nthreads()

dir = joinpath(pwd(),"renamed_genomes")
filepaths = readdir(glob"*.fna", dir)

enc(filepaths[1:2])
milc(filepaths[1:2])
all_cub(filepaths[1:2])

results = Real[]
push!(results, threads)

for i in 1:5
    enc_t = @elapsed enc(filepaths)
    milc_t = @elapsed milc(filepaths)
    all_t = @elapsed all_cub(filepaths)
    push!(results, enc_t, milc_t, all_t)
end


write(joinpath(pwd(), "julia_results", "threads_$threads.csv"), join(results, ','))


