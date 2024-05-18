import requests

url = 'http://localhost:5000/factors/get'
myobj = {'a': '1', 'b': '2', 'c': '1'}

x = requests.post(url, json = myobj)

print(x.text)
