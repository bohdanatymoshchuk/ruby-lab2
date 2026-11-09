require "tempfile"
require "fileutils"

def safe_write(filepath, content)
  dir = File.dirname(filepath)
  tmp = Tempfile.new([File.basename(filepath), ".tmp"], dir)
  begin
    tmp.write(content)
    tmp.flush
    tmp.fsync 
    tmp.close
    File.chmod(0o644, tmp.path)
    File.rename(tmp.path, filepath) 
  rescue StandardError
    tmp.close! 
    raise
  end
end

def safe_write2(filepath, content)
  tmp_path = "#{filepath}.tmp"
  File.write(tmp_path, content)
  FileUtils.mv(tmp_path, filepath)
rescue StandardError
  File.delete(tmp_path) if tmp_path && File.exist?(tmp_path)
  raise
end

class BadContent
  def to_s
    raise "збій під час запису"
  end
end

path = File.join(__dir__, "sandbox", "safe.txt")
FileUtils.mkdir_p(File.dirname(path))
File.write(path, "СТАРИЙ ВМІСТ\n")

[[:safe_write, "Спосіб 1 (tempfile)"], [:safe_write2, "Спосіб 2 (.tmp + mv)"]].each do |meth, title|
  puts " #{title} "
  send(meth, path, "Новий вміст через #{meth}\n")
  puts "Після успішного запису: #{File.read(path).strip}"

  begin
    send(meth, path, BadContent.new)
  rescue => e
    puts "Помилка: #{e.message}"
  end
  puts "Після збою (файл не пошкоджено): #{File.read(path).strip}"
  puts "Тимчасових файлів не залишилось: #{Dir.glob(File.join(File.dirname(path), '*.tmp*')).empty?}"
  puts
end