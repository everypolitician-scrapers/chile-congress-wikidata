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

ids = %w(Q29044330)

names = pages.map { |c| WikiData::Category.new(c, 'es').member_titles }.flatten.uniq
EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { es: names })
