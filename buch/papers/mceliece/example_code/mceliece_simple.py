#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Apr 18 08:58:30 2021

@author: terminator
"""
import numpy as np
from numpy.polynomial import Polynomial as Poly


def gen_perm_M(n):
    '''
    generating random binary permutation matrix: https://en.wikipedia.org/wiki/Permutation_matrix 

    Parameters
    ----------
    n : int
        size of output matrix.

    Returns
    -------
    perm_M : np.ndarray
        binary permutation matrix.

    '''
    perm_M=np.zeros((n, n), dtype=int)
    perm_V=np.random.default_rng().permutation(n)
    perm_M[perm_V, np.r_[0:n]]=1
    return perm_M



def create_linear_code_matrix(n, k, g):
    '''
    create generator matrix for linear encoding
    use this matrix to create code_vector: matrix @ data_vector=code_vector

    Parameters
    ----------
    n : int
        len of code_vector (matrix @ data_vector).
    k : int
        len of data_vector.
    g : numpy.Polynominal
        polynomina wich defines the the constellations of .

    Returns
    -------
    np.ndarray
        Generator matrix

    '''
    if n != k+len(g)-1:
        raise Exception("n, k not compatible with degree of g")
    rows=[]
    for i in range(k): #create potences of p
        row=np.r_[np.zeros(i), g.coef, np.zeros(n-k-i)]
        rows.append(row)
    return np.array(rows, dtype=int).T


def gf2_inv(M, get_full=False):
    '''
    create inverse of matrix M in gf2

    Parameters
    ----------
    M : numpy.ndarray
        input Matrix.
    get_full : Bool, optional
        if Ture, return inverse of G with I on the left (if gaussian inversion successful) If True, vaidity is not proven. The default is False.

    Returns
    -------
    np.ndarray or None
        returns inverse if M was not singular in gf2, else None.

    '''
    size=len(M)
    G=np.hstack((M, np.eye(size)))
    G=np.array(G, dtype=int)
    for n in range(size): #forward reduction
        if G[n, n] == 0:    #swap line if necessary
            for i in range(n+1, size):
                if G[i, n]:
                    G[i, :], G[n, :] = G[n, :].copy(), G[i, :].copy()   #swap
            
        for i in range(n+1, size): #downward reduction
            if G[i, n]:
                G[i, :] = G[i, :] ^ G[n, :]
    #reached buttom_right with pivo 
    for n in range(size-1, -1, -1):  #backwards
        for i in range(n):
            if G[i, n]:
                G[i, :]= G[i, :] ^ G[n, :]
                

                    
    if get_full:
        return G
    else:
        valid=np.sum(np.abs(G[:, :size]-np.eye(size))) == 0  #reduction successfull when eye left on the left of G        
        if not valid:
            return None
        else:
            return G[:, size:]

def create_rand_bin_M(n, with_inverse=False):
    '''
    create random binary matrix

    Parameters
    ----------
    n : int
        size.
    with_inverse : bool, optional
        if False, return only random binary matrix.
        if True, return also inverse of random martix. for this purpose, random matrix will not be singular.
        The default is False.

    Returns
    -------
    M : TYPE
        if with_inverse is True: return tuple(random_matrix, inverse_of_random_matrix)
        else: return random_matrix

    '''
    inv=None
    while type(inv) == type(None):  #do it until inversion of m is successful wich means det(M)%2 != 0
        M=np.random.randint(0,2, (n,n))
        inv=gf2_inv(M)
    if with_inverse:
        return(M, inv)
    else:
        return M
    
def create_syndrome_table(n, g):
    '''
    create syndrome table for correcting errors in linear code

    Parameters
    ----------
    n : int
        len of linear-code code_vector.
    g : numpy.Polinominal
        generator polynominal used by linear-code-encoder.

    Returns
    -------
    list of error_vectors, one per syndrome. 
        get the corresponding error_vector by using the value represented by your syndrome as index of this list.

    '''
    zeros=np.zeros(n, dtype=int)
    syndrome_table=[0 for i in range(n+1)]
    syndrome_table[0]=zeros #when syndrome = 0, no bit-error to correct
    for i in range(n):
        faulty_vector=zeros.copy()
        faulty_vector[i]=1
        q, r=divmod(Poly(faulty_vector), g)
        r=np.r_[r.coef%2, np.zeros(len(g)-len(r))]
        index=np.sum([int(a*2**i) for i, a in enumerate(r)])
        syndrome_table[index]=faulty_vector
    return np.array(syndrome_table)
        
    
def decode_linear_code(c, g, syndrome_table):
    '''
    function to decode codeword encoded with linear_code

    Parameters
    ----------
    c : list or np.ndarray
        code_vector.
    g : numpy.Polynominal
        generator polynominal, used to create code_vector.
    syndrome_table : list of error_vectors
        if codeword contains an error, syndrome_table is used to correct wrong bit.

    Returns
    -------
    numpy.ndarray
        data_vector.

    '''
    q, r=divmod(Poly(c), g)
    q=np.r_[q.coef%2, np.zeros(len(c)-len(q)-len(g)+1)]
    r=np.r_[r.coef%2, np.zeros(len(g)-len(r))]
    syndrome_index=np.sum([int(a*2**i) for i, a in enumerate(r)])
    while syndrome_index > 0:
        c=c ^ syndrome_table[syndrome_index]
        q, r=divmod(Poly(c), g)
        q=np.r_[q.coef%2, np.zeros(len(c)-len(q)-len(g)+1)]
        r=np.r_[r.coef%2, np.zeros(len(g)-len(r))]
        syndrome_index=np.sum([int(a*2**i) for i, a in enumerate(r)])
    return np.array(q, dtype=int)
    
def encode_linear_code(d, G):
    '''
    uses generator matrix G to encode d

    Parameters
    ----------
    d : numpy.ndarray
        data_vector.
    G : numpy.ndarray
        generator matrix.

    Returns
    -------
    c : numpy.ndarray
        G @ d.

    '''
    c=(G @ d)%2
    return c

def encrypt(d, pub_key, t):
    '''
    encrypt data with public key, adding t bit-errors

    Parameters
    ----------
    d : numpy.ndarray or list of numpy.ndarray
        data_vector or list of data vectors to encrypt.
    pub_key : numpy.ndarray
        public key matrix used to encrypt data.
    t : int
        number of random errors to add to code_vector.

    Returns
    -------
    numpy.ndarray or list of numpy.ndarray (depending on d)
        encrypted data.

    '''
    if type(d) in (list,):
        encrypted_list=[encrypt(data, pub_key, t) for data in d]
        return encrypted_list
    else:
        c = np.array((pub_key @ d)%2, dtype=int)
        
        indexes_of_errors=np.random.default_rng().permutation(pub_key.shape[0])[:t] #add t random errors to codeword
        e=np.zeros(pub_key.shape[0], dtype=int)
        e[indexes_of_errors]=1
        c=c ^ e
        return np.array(c, dtype=int)

def decrypt(c, P_inv, linear_code_decoder, S_inv):
    '''
    decrypt encrypted message

    Parameters
    ----------
    c : numpy.ndarray or list of numpy.ndarray
        code_vector or list of code_vectors to decrypt.
    P_inv : numpy.ndarray
        inverted permutation matrix.
    linear_code_decoder : function(x)
        function to use to decode linear code.
    S_inv : numpy.ndarray
        inverted random binary matrix.

    Returns
    -------
    numpy.ndarray or list of numpy.ndarray (depending on d)
        decrypted data.

    '''
    if type(c) in (list,):
        decrypted_list=[decrypt(codew, P_inv, linear_code_decoder, S_inv) for codew in c]
        return decrypted_list
    else:
        c=np.array(P_inv @ c, dtype=int)%2
        d=linear_code_decoder(c)
        d=(S_inv @ d)%2
        return np.array(d, dtype=int)

def str_to_blocks4(string):
    blocks=[]
    for char in string:
        bits=[int(value) for value in np.binary_repr(ord(char), 8)[::-1]] #lsb @ index 0
        blocks.append(np.array(bits[:4], dtype=int)) #lower nibble first
        blocks.append(np.array(bits[4:], dtype=int))
    return blocks

def blocks4_to_str(blocks):
    string=''
    for i in range(0, len(blocks), 2):
        char=np.sum([b*2**i for i, b in enumerate(blocks[i])]) + \
            np.sum([b*2**(i+4) for i, b in enumerate(blocks[i+1])])
        string+=chr(char)
    return string

#shared attributes:
n=7
k=4
t=1

#private key(s):
g=Poly([1,1,0,1])  #generator polynom for 7/4 linear code (from table, 1.0 + 1.0·x¹ + 0.0·x² + 1.0·x³)
P_M=gen_perm_M(n)    #create permutation matrix
G_M=create_linear_code_matrix(n, k, g)  #linear code generator matrix
S_M, S_inv=create_rand_bin_M(k, True) #random binary matrix and its inverse
P_M_inv=P_M.T #inverse permutation matrix

syndrome_table=create_syndrome_table(n, g) #part of linear-code decoder
linear_code_decoder=lambda c:decode_linear_code(c, g, syndrome_table)

#public key:
pub_key=(P_M @ G_M @ S_M)%2


msg_tx='Hello World?'

blocks_tx=str_to_blocks4(msg_tx)
encrypted=encrypt(blocks_tx, pub_key, t)

blocks_rx=decrypt(encrypted, P_M_inv, linear_code_decoder, S_inv)
msg_rx=blocks4_to_str(blocks_rx)

print(f'msg_rx: {msg_rx}')
        
        