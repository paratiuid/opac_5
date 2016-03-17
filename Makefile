
#########
## deps #
#########
update_requirements:
	pip install --upgrade -r requirements.txt

#########
## i18n #
#########

# Faz um scan em toda a app buscando strings traduzíveis e o resultado fica em app/translations/messages.pot
make_messages:
	pybabel extract -F app/config/babel.cfg -k lazy_gettext -k __ -o app/translations/messages.pot .

# cria o catalogo para o idioma definido pela variável LANG, a partir das strings: app/translations/messages.pot
# executar: $ LANG=en make create_catalog
create_catalog:
	pybabel init -i app/translations/messages.pot -d app/translations -l $(LANG)

# atualiza os catalogos, a partir das strings: app/translations/messages.pot
update_catalog:
	pybabel update -i app/translations/messages.pot -d app/translations

# compila as traduções dos .po em arquivos .mo prontos para serm utilizados.
compile_messages:
	pybabel compile -d app/translations

#########
## test #
#########

test:
	export OPAC_CONFIG="config/templates/testing.template" && python manager.py test

test_coverage:
	export OPAC_CONFIG="config/templates/testing.template" && export FLASK_COVERAGE="1" && python manager.py test
