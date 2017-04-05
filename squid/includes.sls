{% from "squid/map.jinja" import map with context %}

include:
  - squid

{% set target = salt['pillar.get']('squid:includes:target', '*') %}
{% set expr_form = salt['pillar.get']('squid:includes:expr_form', 'glob') %}
{% set function = salt['pillar.get']('squid:includes:mine_function', 'squid_hosts') %}
{% set template = salt['pillar.get']('squid:includes:template', '') %}

{% set hosts = salt['mine.get'](target, function, expr_form=expr_form)|default(False) %}

{%- if hosts %}
squid_includes_dir:
  file.directory:
    - name: {{ map.conf_dir }}/{{ map.includes_dirname }}
    - clean: True

  {% for host, data in hosts.items() %}
squid_include_{{ host }}:
  file.managed:
    - name: {{ map.conf_dir }}/{{ map.includes_dirname }}/{{ host }}.conf
    - source: {{ template }}
    - template: jinja
    - require:
      - file: squid_includes_dir
    - context:
      host: {{ host }}
      data: {{ data }}
  {%- endfor %}
{% endif %}

