package com.tis5.NossoSindico.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;

import javax.persistence.*;

@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "condominio")
public class Condominio {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_condominio")
    private long id;

    @Column
    private String nome;

    @Column
    private String rua;

    @Column
    private String bairro;

    @Column
    private String cep;

    @Column
    private String cidade;

    @Column
    private int numero;
    
    @Column(name="acesso")
    @Autowired
    private String code;

}
