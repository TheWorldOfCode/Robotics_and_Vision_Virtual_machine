import sdurw, sdurws, sdurwsim
import numpy as np

print(" --- Program started --- \n")

print("Joint configuration of size 6:")
q = sdurw.Q(6, 1, 2, 3, 4, 5, 6)
print(q, "\n")

print("Transform3D with a position vector at zero and a identity rotation:")
T = sdurw.Transform3Dd()
print(T, "\n")

print("Transform3D constructed by position vector and PRY rotation (or Rotation3D) and get its position and rotation:")
V1 = sdurw.Vector3Dd(42, 84, 126)
print(V1)
R1 = sdurw.RPYd(np.pi/2, np.deg2rad(15), np.pi)
print(R1)
print(R1.toRotation3D())
T1 = sdurw.Transform3Dd(V1, R1.toRotation3D())
print("T1:", T1)
print("T1:", T1.P())
print("T1:", T1.R(), "\n")

print("Equivalent angle axis constructed by a direction vector:")
V = sdurw.Vector3Dd(42, 84, 126)
V /= V.norm2()
eaa = sdurw.EAAd(V, np.deg2rad(45))
print(eaa)
print(eaa.angle())
print(eaa.axis(), " = ", V)

print(" --- Program ended ---")