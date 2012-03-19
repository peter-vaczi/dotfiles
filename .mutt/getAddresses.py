#!/usr/bin/python

import ldap
import sys

URI     = 'ldap://10.159.0.11'
BASE    = 'ou=users,ou=useraccounts,dc=nsn-intra,dc=net'
BINDDN  = 'NSN-INTRA\\vaczi'
SCOPE   = ldap.SCOPE_SUBTREE
ATTRLIST = ('mail', 'displayName', 'co', 'title', 'department')

if len(sys.argv) < 2:
    print("usage: %s <name>" % sys.argv[0])
    sys.exit(1)

name = sys.argv[1]

pwfile = open('/home/vaczi/.ldappasswd', 'r')
password = pwfile.read()

filter = '(&(|(name=%s*)(givenName=%s*))(objectclass=organizationalPerson))' % (name, name)

try:
    l = ldap.initialize(URI)
    l.simple_bind(BINDDN, password)
except ldap.LDAPError, e:
    print("Error: %s" % e)
    sys.exit(2)

print("# searching '%s' ..." % name)

try:
    searchres = l.search_ext_s(BASE, SCOPE, filter, ATTRLIST)
except:
    pass

for (dn, attrs) in searchres:
    try:
        mail = attrs["mail"][0]
        name = attrs["displayName"][0]
        title = ""
        co = ""
        dep = ""
        if 'title'      in attrs: title = attrs["title"][0]
        if 'co'         in attrs: co    = attrs["co"][0]
        if 'department' in attrs: dep   = attrs["department"][0]
        print('%s\t%s\t%s - %s - %s' % (mail, name, title, co, dep))
    except:
        pass



