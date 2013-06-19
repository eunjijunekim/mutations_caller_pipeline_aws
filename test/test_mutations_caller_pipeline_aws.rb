require 'test/unit'
require 'mutations_caller_pipeline_aws'

class MutationsCallerPipelineAwsTest < Test::Unit::TestCase
  def test_hi
    assert_equal("Hello World!", MutationsCallerPipelineAws.hi)
    #File.delete("haas")
  end

  def check_memory(cmd)
    dj = cmd[ /\DJ \s*(\d+(?:\.\d+)?)/,1].to_i
    if dj == 0
      dj = 1
    end
    memory = cmd[ /\h_vmem=\s*(\d+(?:\.\d+)?)/,1].to_i
    num = dj * memory
  end

  def test_bwa_caller
    #call_paired_end(r1, r2, sai1, sai2,  sam_file, index, log_file, bwa, samtools, job_prefix,account, debug)
    #k = BwaCaller.call_paired_end("r1", "r2","sai1", "sai2" , "out_file", "index", "haas", "bwa", "samtools", 837823789, "haer", 4)
    
  end

  def test_samtools_indexing

  end

  def test_picard_caller
  #test enough memory
    # convert(sam_file, bam_file, picard_tools, log_file, job_prefix, account)
    cmd = PicardCaller.convert("sam_file", "bam_file", "~/Documents/picard_tools", "log_file", 12345, "kim")
    mem = check_memory(cmd)
    assert(mem >=14, true)

    # rg_and_sorting(bam_file, bam_file_sorted, picard_tools, library, index, sample_name, log_file, id, job_prefix, account)
    cmd = PicardCaller.rg_and_sorting("bam_file", "bam_file", "~/Documents/picard_tools", "library","index","sample_name", "log_file", 1, 12345, "kim")
    mem = check_memory(cmd)
    assert(mem >=14, true)

    # mark_duplicates(bam_file_sorted, bam_file_sorted_duplicates, duplicate_metrcis, picard_tools, log_file, job_prefix, account)
    cmd = PicardCaller.mark_duplicates("bam_sorted", "bam_dup", "dup_met", "~/Documents/picard_tools", "log_file", 12345, "kim")
    mem = check_memory(cmd)
    assert(mem >=14, true)

    # build_index(bam_file_sorted_duplicates, picard_tools, log_file, job_prefix, account)
    cmd = PicardCaller.build_index("bam_file_sorted_duplicates",  "~/Documents/picard_tools", "log_file", 12345, "kim")
    mem = check_memory(cmd)
    assert(mem >=14, true)

  end

  def test_gatk_caller
    #test enough memory

    # call(log_dir, gatk, index_fa, read_bam, read_vcf, job_prefix, account,dbsnp_file)
    cmd = GatkCaller.call("log_dir", "gatk", "index_fa", "read_bam", "read_vcf", 12344, "account","dbsnp_file")
    mem = check_memory(cmd)
    assert(mem >=14, true)

    # coverage(log_dir, gatk, index_fa, read_bam, outfile_prefix, job_prefix, account)
    cmd = GatkCaller.coverage("log_dir", "gatk", "index_fa", "read_bam", "outfile_prefix", 12344, "account")
    mem = check_memory(cmd)
    assert(mem >=14, true)

    # recalibrate_bam(log_dir ,gatk, index_fa, read_bam, recal_file, job_prefix, account, dbsnp_file)
    cmd = GatkCaller.recalibrate_bam("log_dir", "gatk", "index_fa", "read_bam", "recal_file", 12344, "account","dbsnp_file")
    mem = check_memory(cmd)
    assert(mem >=14, true)

    # table_calibration(log_dir, gatk, index_fa, read_bam, recal_bam, recal_file, job_prefix, account)
    cmd = GatkCaller.table_calibration("log_dir", "gatk", "index_fa", "read_bam", "recal_bam", "recal_bam", 12344, "account")
    mem = check_memory(cmd)
    assert(mem >=14, true)
    puts cmd
    #check on account and star?
    
    # realigne(log_dir, gatk, read_bam, index_fa, target_intervals, realigned_bam, job_prefix, account, star)
    cmd = GatkCaller.realigne("log_dir", "~/Documents/GATK/dist/GenomeAnalysisTK.jar", "read_bam", "index_fa", "target_int","realigned_bam",989898,"kim","star")
    mem = check_memory(cmd)
    assert(mem >=14, true)
    puts cmd
    
    # prepare_realigne(log_dir, gatk, read_bam, index_fa, target_intervals, job_prefix, account, dbsnp_file, star)
    cmd = GatkCaller.prepare_realigne("log_dir", "~/Documents/GATK/dist/GenomeAnalysisTK.jar", "read_bam", "index_fa", "target_int", 12312, "kim", "dbsnp", "star")
    mem = check_memory(cmd)
    assert(mem >=14, true)
    
  end

  def test_create_location_file

  end
end
