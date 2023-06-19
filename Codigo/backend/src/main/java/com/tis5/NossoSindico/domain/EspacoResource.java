package com.tis5.NossoSindico.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EspacoResource {
    private long id;

    private String nome;

    private String descricao;

    private int capacidadeMax;

    private long id_condominio;
}
