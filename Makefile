init:
	pip install '.[dist]'
	pip install -e .

load:
	xontrib load simplejump

wheel:
	python setup.py bdist_wheel

upload: wheel
	twine upload -r pypi dist/*.whl
