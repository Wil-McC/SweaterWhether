class SalaryService
  def self.fetch_salaries(des)
    res = ua_connection.get("/api/urban_areas/slug:#{des}/salaries")

    data = JSON.parse(res.body, symbolize_names: true)

    target_roles(data[:salaries])
  end

  def self.target_roles(jobs)
    list = ['Data Analyst', 'Data Scientist', 'Mobile Developer', 'QA Engineer', 'Software Engineer', 'Systems Administrator', 'Web Developer' ]
    # refactor to not repeat iteration - if list.includes?(job[:job][:title])
    list.flat_map do |role|
      jobs.each_with_object({}) do |job, acc|
        if job[:job][:title] == role
          acc[:title] = job[:job][:title]
          acc[:min]   = job[:salary_percentiles][:percentile_25].round(2)
          acc[:max]   = job[:salary_percentiles][:percentile_75].round(2)
        end
      end
    end
  end

  def self.ua_connection
    ua_connection ||= Faraday.new({
      url: 'https://api.teleport.org'
    })
  end
end
