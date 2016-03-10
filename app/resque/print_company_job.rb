module PrintCompanyJob
  @queue = :default

  def self.perform
    Company.all.each { |e| puts e.name }
  end
end
