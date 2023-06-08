FROM mirantistraining/lab-builder

ADD . /docs

CMD  make clean; make html