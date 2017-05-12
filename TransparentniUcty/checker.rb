#!/usr/bin/env ruby

require 'json'

ACCOUNT_REGEXP = /\A[0-9-]*\/[0-9]{4}\Z/

REQUIRED_ATTRIBUTES = {
  "Id" => {},                 # unikatni ID
  "CisloUctu" => {            # cislo uctu, ve kterem polozka je. Povinne
    regexp: ACCOUNT_REGEXP,
    required: true
  } ,                 
  "Datum" => {                # datum pripsani na ucet. Povinne
    required: true
  },
  "PopisTransakce" => {},     # popis transakce, obvykle od banky
  "NazevProtiuctu" => {},     # nazev uctu, odkud/kam jdou penize. Casto prazdne
  "CisloProtiuctu" => {       # cislo uctu, odkud/kam jdou penize. Povinne
    regexp: ACCOUNT_REGEXP,
    required: true,
  },
  "ZpravaProPrijemce" => {},  # Zprava od odesilatele penez, ci pro adresata
  "VS" => {},                 # Variabilni symbol
  "KS" => {},                 # Konstantni symbol
  "SS" => {},                 # Specificky symbol
  "Castka" => {               # Castka v mene uctu, povinné
    regexp: /\A[-]?[0-9]{1,}[\.]?[0-9]*\Z/,
    required: true
  },
  "AddId" => {}
}

filename = ARGV[0]
STDERR.puts "Reading #{filename}\n"
file = File.read(filename)

data = JSON.parse(file)

required_keys = REQUIRED_ATTRIBUTES.select { |k,v| k if v[:required] }.keys

def check_entry(key, value)
  check = REQUIRED_ATTRIBUTES[key]
  return false if check[:required] && value.to_s == ''
  return false if check[:regexp] && value.to_s !~ check[:regexp]
  true
end

err = 0
errs = {}
data.each do |entry|
  # check required
  unless entry.keys & required_keys == required_keys
    puts "ERR: missing required attribute! #{entry.inspect}" 
    err += 1
    has_error = true
  end
  entry.each do |k, v|
    unless check_entry(k, v)
      errs[k] ||= 0
      errs[k] += 1
      puts "ERR: invalid attribute '#{k}' (val: '#{v}') in #{entry.inspect}"
      err += 1
      has_error = true
    end
  end
  puts " " if has_error
  has_error = false
end
if errs
  STDERR.printf "%15s | %s\n", 'Field', 'Count'
  STDERR.puts "-" * 80
  errs.each do |k,v|
    STDERR.printf "%15s | %d\n", k, v
  end
end
STDERR.puts "\nEntries: #{data.count}, errors: #{err}"

