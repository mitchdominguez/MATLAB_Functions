function q_bun = quat_bun(q)
Psi = quat_psimat(q);
q_bun = [Psi q];
end