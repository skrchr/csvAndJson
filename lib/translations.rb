# require './lib/translations'
# Translations.import './tmp/translations-2018-05-15-vas.xlsx'
require 'json'
require 'csv'
require 'roo'


class Translations

  def self.export lang
    data = JSON.parse(File.read("./app/assets/#{lang}.json"));


    translations = []
    data.each do |k, v|
      key = [k]
      if v.is_a?(Hash)
        v.each do |k1, v1|
          key = [k, k1]
          
          if v1.is_a?(Hash)
            v1.each do |k2, v2|
              key = [k, k1, k2]
              
              if v2.is_a?(Hash)
                v2.each do |k3, v3|
                  key = [k, k1, k2, k3]
                  
                  if v3.is_a?(Hash)
                    v3.each do |k4, v4|
                      key = [k, k1, k2, k3, k4]
                      
                      if v4.is_a?(Hash)
                        v4.each do |k5, v5|
                          key = [k, k1, k2, k3, k4]
                          translations << { key.join('.') => v5 } if v5.present?
                        end
                      else
                        translations << { key.join('.') => v4 } if v4.present?
                      end
                      
                    end
                  else
                    translations << { key.join('.') => v3 } if v3.present?
                  end
                end
              else
                translations << { key.join('.') => v2 } if v2.present?
              end
            end
          else
            translations << { key.join('.') => v1 } if v1.present?
          end
        end
      else
        translations << { key.join('.') => v } if v.present?
      end
    end
    
    return translations



  end


  def self.read_xls lang, file
    x = Roo::Excel.new(file)
    translations = {}
    x.sheet(0).each(key: 'keys',lang: lang) do |hash|
      translations[hash[:key]] = hash[:lang]
    end
    translations.delete("keys")
    return translations

  end
  
  def self.compare lang, file

    xls_hash = read_xls lang, file
    data_hash = export lang
    data_hash = data_hash.reduce Hash.new, :merge

    puts "NEW XLS has the following differences"
    xls_hash.each do |key,value|
      if data_hash[key] != value && data_hash[key] != nil
        puts 'OLD TEXT = ' + data_hash[key].to_s + '  NEW TEXT ' + value.to_s
      elsif  data_hash[key] == nil
        puts 'NEW KEY: ' + key.to_s + " => " + value.to_s
      end

    end



    
  end

  def self.compareAndImport lang, file
    compare lang, file
    xls_hash = read_xls lang, file
    data_hash = export lang
    data_hash = data_hash.reduce Hash.new, :merge

    puts "NEW XLS has the following differences"
    xls_hash.each do |key,value|
      if data_hash[key] != value && data_hash[key] != nil
        data_hash[key] = value
      elsif  data_hash[key] == nil
        data_hash[key] = value
      end

    end

    getToWriteToFile = exportNewJsonFiles data_hash
    File.open("./app/assets/temp"+lang+".json","w") do |f|
      f.write(getToWriteToFile.to_json)
    end

  end


  def self.exportNewJsonFiles object
  newObject = {}
  object.each do |key,value|
    puts newObject
    splitArray = key.split('.')
    splitArray.each do |item|
       if (splitArray.length == 1)
        newObject[splitArray[0]] = object[key].to_s
       elsif(splitArray.length == 2)
        if(newObject[splitArray[0]] == nil)
          newObject[splitArray[0]] = {}
       
        end
        newObject[splitArray[0]][splitArray[1]] = object[key].to_s
        puts newObject[splitArray[0]][splitArray[1]]
       elsif(splitArray.length == 3)
        if (newObject[splitArray[0]] == nil)
          newObject[splitArray[0]] = {}
        end
        if(newObject[splitArray[0]][splitArray[1]]==nil)
          newObject[splitArray[0]][splitArray[1]] = {}
        end
        newObject[splitArray[0]][splitArray[1]][splitArray[2]] = object[key].to_s
      else
        puts "more than 3 levels, we need to add"
      end
    end
    

  end

  return newObject

  end

end





