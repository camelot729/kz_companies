require 'roo-xls'
require 'roo'
require 'spreadsheet'
require 'open-uri'
require 'net/http'
require 'typhoeus' 
require 'zip'


namespace :parser do


    task download: :environment do


        page = Nokogiri::HTML(open("http://stat.gov.kz/faces/publicationsPage/publicationsOper/homeNumbersBusinessRegisters/homeNumbersBusinessRegistersReestr?_afrLoop=21198108469843931#%40%3F_afrLoop%3D21198108469843931%26_adf.ctrl-state%3Dg7yhel50f_4"), nil, "UTF-8")

        links = page.css('div[id="pt1:r1:0:j_id__ctru0pc3:pgl4"] a')


        links.each_with_index do |link, i|
            if i > 0
                l = "http://stat.gov.kz" + link["href"]
                puts l
                puts "#{i} #{link.text}"
                

                uri = URI(l)
                #here need change path
                filename = "/Users/Kamil/zip/#{i}.zip"

                Net::HTTP.start(uri.host, uri.port, use_ssl: (uri.scheme == 'https')) do |http|
                  request = Net::HTTP::Get.new uri.request_uri
                  http.request(request) do |response|
                    File.open(filename, 'wb') do |io|
                      response.read_body do |chunk|
                        io.write(chunk)
                      end
                    end
                  end
                end
            end
        end

        1.upto(links.count-1) do |i|
            #here need change path
            file_path = "/Users/Kamil/zip/#{i}.zip"
            Zip::File.open(file_path) do |zip_file|
                zip_file.each do |f|
                    #here need change path
                    f_path=File.join("/Users/Kamil/zip/unzip", "#{i}.xls")
                    FileUtils.mkdir_p(File.dirname(f_path))
                    zip_file.extract(f, f_path) unless File.exist?(f_path)
                end
            end
        end

        1.upto(links.count-1) do |j|
            #here need change path
            book = Spreadsheet.open "/Users/Kamil/zip/unzip/#{j}.xls"
            row = book.worksheet 0 
            puts "Found #{row.count} row"

            size = row.row(4).length
            column_name = row.row(3)
            4.upto(row.count) do |i|
                m = KzCompany.new
                column = row.row(i)
                m[:bin_code] = column[0]
                m[:okpo_code] = column[1]
                m[:full_name_of_the_organization] = column[3]
                m[:date_of_organization] = column[4]
                m[:main_oked] = column[5]
                m[:name_of_main_activity] = column[7]
                m[:secondary_oked] = column[8]
                m[:krp_code] = column[9]
                m[:krp_name] = column[11]
                m[:kato_code] = column[12]
                m[:name_of_locality] = column[14]
                m[:legal_address] = column[15]
                m[:full_name] = column[16]
                m.save!
            end
        end


    end

    task unzip: :environment do
        file_path = "/Users/Kamil/zip/1.zip"
        Zip::File.open(file_path) do |zip_file|
            zip_file.each do |f|
                f_path=File.join("/Users/Kamil/zip/unzip", "#{1}.")
                FileUtils.mkdir_p(File.dirname(f_path))
                zip_file.extract(f, f_path) unless File.exist?(f_path)
            end
        end
    end


    task write: :environment do
        
        book = Spreadsheet.open '/Users/Kamil/Desktop/11.xls'
        row = book.worksheet 0 
        puts "Found #{row.count} row"

        size = row.row(4).length
        column_name = row.row(3)
        4.upto(row.count) do |i|
            m = KzCompany.new
            column = row.row(i)
            m[:bin_code] = column[0]
            m[:okpo_code] = column[1]
            m[:full_name_of_the_organization] = column[3]
            m[:date_of_organization] = column[4]
            m[:main_oked] = column[5]
            m[:name_of_main_activity] = column[7]
            m[:secondary_oked] = column[8]
            m[:krp_code] = column[9]
            m[:krp_name] = column[11]
            m[:kato_code] = column[12]
            m[:name_of_locality] = column[14]
            m[:legal_address] = column[15]
            m[:full_name] = column[16]
            m.save!
        end

    end
end


end