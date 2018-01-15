# Use an official Python runtime as a parent image
FROM python:2.7-slim

ADD hereWeCode.py /
ADD requirements.txt /

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r ./requirements.txt

# Here we insert some data
CMD ["python", "./hereWeCode.py"]
