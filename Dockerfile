FROM python:2

COPY . /work/

# Note: can't remove pip, provides pkg_resources
RUN cd /work && \    
    \
    cd blockade && \
    pip install -r requirements.txt && \
    python setup.py install && \
    cd .. && \
    \    
    rm -r /var/cache/*

WORKDIR /blockade
ENTRYPOINT ["blockade"]
