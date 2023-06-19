package com.tis5.NossoSindico.repository;

import com.tis5.NossoSindico.domain.Condominio;
import com.tis5.NossoSindico.domain.Espaco;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EspacoRepository extends JpaRepository<Espaco,Long> {
    List<Espaco> findByCondominio(Condominio condominio);
}
