#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'wikidata/fetcher'
require 'pry'
require 'rest-client'

@pages = [
  'Categoría:Diputados del XLVIII Periodo Legislativo del Congreso Nacional de Chile',
  'Categoría:Diputados del XLIX Período Legislativo del Congreso Nacional de Chile',
  'Categoría:Diputados del L Periodo Legislativo del Congreso Nacional de Chile',
  'Categoría:Diputados del LI Periodo Legislativo del Congreso Nacional de Chile',
  'Categoría:Diputados del LII Periodo Legislativo del Congreso Nacional de Chile',
  'Categoría:Diputados del LIII Periodo Legislativo del Congreso Nacional de Chile',
  'Categoría:Diputados del LIV Periodo Legislativo del Congreso Nacional de Chile',
]

ids = @pages.map { |c| WikiData::Category.new(c, 'es').wikidata_ids }.flatten.uniq
ids.each_with_index do |id, i|
  puts i if (i % 50).zero?
  data = WikiData::Fetcher.new(id: id).data('es') or next
  ScraperWiki.save_sqlite([:id], data) rescue binding.pry
end
warn RestClient.post ENV['MORPH_REBUILDER_URL'], {} if ENV['MORPH_REBUILDER_URL']
