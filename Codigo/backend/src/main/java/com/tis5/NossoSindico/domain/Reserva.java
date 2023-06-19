package com.tis5.NossoSindico.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "reserva")
public class Reserva {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_reserva")
    private long id;

    @Column
    private LocalDateTime data;

    @ManyToOne(cascade = CascadeType.REMOVE)
    private Apartamento apto;

    @ManyToOne(cascade = CascadeType.REMOVE)
    private Espaco lugar;
}
