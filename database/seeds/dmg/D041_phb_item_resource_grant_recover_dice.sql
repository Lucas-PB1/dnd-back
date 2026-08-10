-- Recover 1dN ao amanhecer (Descanso Longo) — pools de cargas com fórmula DMG.
-- 1×/amanhecer (Use) permanece recover_all_on_long = TRUE sem dados.

UPDATE rpg.phb_resource_grant gr
SET
  recover_on_long_dice = v.dice,
  recover_all_on_long = FALSE
FROM rpg.phb_resource_definition rd
JOIN (
  VALUES
    -- Varinhas comuns (1d6+1 / max 7)
    ('varinhaImobilizadoraCharges', '1d6+1'),
    ('varinhaMedoCharges', '1d6+1'),
    ('varinhaMisseisCharges', '1d6+1'),
    ('varinhaTeiaCharges', '1d6+1'),
    ('varinhaPolimorfiaCharges', '1d6+1'),
    ('varinhaRelampagosCharges', '1d6+1'),
    ('varinhaCuspidoraFogoCharges', '1d6+1'),
    ('varinhaPirotecnicaCharges', '1d6+1'),
    ('varinhaDetectarInimigoCharges', '1d6+1'),
    ('varinhaParalisiaCharges', '1d6+1'),
    ('varinhaFarejadoraCharges', '1d6+1'),
    ('varinhaSegredosCharges', '1d3'),
    ('batutaRegenciaCharges', '1d3'),
    -- Cajados
    ('cajadoCuraCharges', '1d6+4'),
    ('cajadoFogoCharges', '1d6+4'),
    ('cajadoGeloCharges', '1d6+4'),
    ('cajadoEnxameCharges', '1d6+4'),
    ('cajadoFloresCharges', '1d6+4'),
    ('cajadoAvicularCharges', '1d6+4'),
    ('cajadoDefinhamentoCharges', '1d6+4'),
    ('cajadoSortilegiosCharges', '1d6+4'),
    ('cajadoMatasCharges', '1d6+4'),
    ('cajadoAgravoCharges', '1d6'),
    ('cajadoMagificadoCharges', '1d6'),
    ('cajadoPoderCharges', '2d8+4'),
    ('cajadoMagiCharges', '4d6+2'),
    ('armaMagificadaCharges', '1d6'),
    ('armaduraMagificadaCharges', '1d6'),
    -- Anéis / maravilhosos densos em cargas
    ('starRingCharges', '1d6'),
    ('anelEvasaoCharges', '1d3'),
    ('anelArieteCharges', '1d3'),
    ('anelComandoElementalCharges', '1d4+1'),
    ('anelInfluenciarAnimaisCharges', '1d3'),
    ('colarPensamentosCharges', '1d4'),
    ('elmoTeleporteCharges', '1d3'),
    ('gemaVisaoCharges', '1d3'),
    ('gemaClaridadeCharges', '1d3'),
    ('macaTerrorCharges', '1d3'),
    ('tridenteComandarPeixesCharges', '1d3'),
    ('ondaComandoAquaticoCharges', '1d3'),
    ('marteloDoTrovaoCharges', '1d4+1'),
    ('bolsaTemperosCharges', '1d6+4'),
    ('cuboEnergeticoCharges', '1d6'),
    ('cuboPortalCharges', '1d3'),
    ('flautaAtormentadoraCharges', '1d3'),
    ('flautaEsgotosCharges', '1d3'),
    ('carrilhaoDestrancadorCharges', '1d3'),
    ('mantoInvisibilidadeCharges', '1d3'),
    ('botasAladasCharges', '1d3'),
    ('chifreAlarmeSilenciosoCharges', '1d4'),
    ('olhosEnfeiticarCharges', '1d3'),
    ('chapeuVermesCharges', '1d3'),
    ('tunicaCoresCharges', '1d3'),
    ('instrumentoEscritaCharges', '1d3'),
    ('tabuleiroEspiritualCharges', '1d3'),
    ('escaravelhoProtecaoCharges', '1d3'),
    ('olhoMegeraCharges', '1d3'),
    ('talismaMalCharges', '1d3'),
    ('talismaBemCharges', '1d3'),
    ('bolsaTropeliasCharges', '1d6'),
    ('demonomicoCharges', '1d6'),
    ('tunicaEstrelasCharges', '1d6'),
    ('orbesDraconicosCharges', '1d6'),
    ('varinhaMaravilhasCharges', '1d6'),
    ('varinhaOrcusCharges', '1d6'),
    ('olhoVecnaCharges', '1d4+4'),
    ('maoVecnaCharges', '1d4+4')
) AS v(slug, dice) ON rd.slug = v.slug
WHERE gr.resource_id = rd.id
  AND gr.owner_kind = 'item'::rpg.resource_owner_kind;
