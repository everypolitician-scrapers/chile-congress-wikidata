#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

pages = [
  'Categoría:Diputados del XLVIII Periodo Legislativo del Congreso Nacional de Chile',
  'Categoría:Diputados del XLIX Período Legislativo del Congreso Nacional de Chile',
  'Categoría:Diputados del L Periodo Legislativo del Congreso Nacional de Chile',
  'Categoría:Diputados del LI Periodo Legislativo del Congreso Nacional de Chile',
  'Categoría:Diputados del LII Periodo Legislativo del Congreso Nacional de Chile',
  'Categoría:Diputados del LIII Periodo Legislativo del Congreso Nacional de Chile',
  'Categoría:Diputados del LIV Periodo Legislativo del Congreso Nacional de Chile',
]

# Find all P39s of the 8th Period
query = <<EOS
  SELECT DISTINCT ?item WHERE { ?item p:P39 [ ps:P39 wd:Q18067639 ; pq:P2937 wd:Q16493941 ] }
EOS
p39s = EveryPolitician::Wikidata.sparql(query)

names = pages.map { |c| WikiData::Category.new(c, 'es').member_titles }.flatten.uniq
EveryPolitician::Wikidata.scrape_wikidata(ids: p39s, names: { es: names })
