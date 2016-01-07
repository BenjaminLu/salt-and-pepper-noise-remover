function intensity = gotoLevelB(Zxy,  Zmax, Zmin, Zmed)
    B1 = Zxy - Zmin;
    B2 = Zxy - Zmax;

    if B1 > 0 && B2 < 0
        intensity = Zxy;
    else
        intensity = Zmed;
    end
end