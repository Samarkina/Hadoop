import sys
import socket,struct
import csv
import bisect

def readCSV():
    geolite = []
    with open("GeoData.csv") as geolite_input:
        geolite_input_reader = csv.reader(geolite_input, delimiter=',')
        for row in geolite_input_reader:
            geolite.append(row)
    return geolite

def addressInNetwork(ipaddr, netmask):
    return ipaddr & netmask == netmask

def convertList(geolite):
    for i in range(len(geolite)):
        netaddr, bits = geolite[i][0].split('/')
        # netmask = struct.unpack('!I', socket.inet_aton(netaddr))[0] & ((2 << int(bits) - 1) - 1)
        netmask = struct.unpack('!I', socket.inet_aton(netaddr))[0] & ((0xffffffff << (32 - int(bits))) & 0xffffffff)
        geolite[i].append(geolite[i][0])
        geolite[i][0] = netmask
    return geolite

def listOne(geolite):
    geolite0 = []
    for string in geolite:
        geolite0.append(string[0])
    return geolite0

geolite = readCSV()
geolite = convertList(geolite)
geolite.sort()
geolite0 = listOne(geolite)

for line in sys.stdin:
    line = line.strip()
    (purchaseDate2, productName, productPrice, productCategory, clientIPAddress) = line.split('\t')
    ipaddr = struct.unpack('!I', socket.inet_aton(clientIPAddress))[0]

    pos = bisect.bisect_left(geolite0, ipaddr) - 1
    if addressInNetwork(ipaddr, geolite[pos][0]):
        print("\t".join([purchaseDate2, productName, productPrice, productCategory, clientIPAddress, geolite[pos][2], geolite[pos][1]]))
    else:
        print("\t".join([purchaseDate2, productName, productPrice, productCategory, clientIPAddress, geolite[pos][2], "Kateland"]))

