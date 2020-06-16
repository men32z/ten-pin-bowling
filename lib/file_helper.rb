module FileHelper
  def self.read(file, error = [])
    arr = []
    begin
      f = File.open(file, 'r')
      f.each_line do |line|
        line.strip!
        arr.push line
      end
      f.close
      arr
    rescue StandardError => e
      error.push e
      false
    end
  end
end
