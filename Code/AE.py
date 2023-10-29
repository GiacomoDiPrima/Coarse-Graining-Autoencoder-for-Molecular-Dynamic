class cgae(nn.Module):
    
    # La rete ha come argomenti il numero di atomi nella molecola ed il numero di siti CG
    def __init__(self, n_atoms, n_cgs): 
        super().__init__()

        # Viene definita ed inizializzata la mappa di assegnazione con valori casuali
        assign_map = torch.randn(n_atoms, n_cgs) 
        # Viene definita la matrice del decoder
        decode = torch.randn(n_cgs, n_atoms)     
        
        
        self.n_atoms = n_atoms 
        # La matrice della mappa di assegnazione viene aggiunta ai parametri
        # della rete da ottimizzare, così come quella del decoder
        self.assign_map = nn.Parameter(assign_map)  
        self.decode = nn.Parameter(decode)    
        
    # L'input della rete sono le coordinate spaziali atomistiche e la temperatura della Gumbel
    def forward(self, xyz, tau=1.0):     
        
        # Viene eseguito una traslazione delle coordinate per centrarle rispetto l'origine
        xyz = xyz.reshape(-1, self.n_atoms, 3)
        shift = xyz.mean(1)
        xyz = xyz - shift.unsqueeze(1)
        
        # Viene calcolata la riparametrizzazione della matrice dell'encoder
        M = F.gumbel_softmax(self.assign_map, dim=-1)
        M_norm = M / M.sum(-2).unsqueeze(-2)
        
        # Vengono calcolate le coordinate dei siti CG come il prodotto scalare 
        # tra le coordinate atomistiche e la matrice di assegnazione
        cg_xyz = torch.einsum('bij,in->bnj', xyz, M_norm)
        
        # Vengono ricostruite le coordinate atomistiche moltiplicando quelle dei siti CG 
        # con la matrice del decoder
        xyz_recon = torch.einsum('bnj,ni->bij', cg_xyz, self.decode)
        
        return xyz, xyz_recon, M, M_norm, cg_xyz