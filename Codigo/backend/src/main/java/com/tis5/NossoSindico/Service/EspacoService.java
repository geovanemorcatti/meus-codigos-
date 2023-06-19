package com.tis5.NossoSindico.Service;

import com.tis5.NossoSindico.domain.Condominio;
import com.tis5.NossoSindico.domain.Espaco;
import com.tis5.NossoSindico.domain.EspacoResource;
import com.tis5.NossoSindico.domain.*;
import com.tis5.NossoSindico.repository.EspacoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class EspacoService {
    @Autowired
    private EspacoRepository repository;
    @Autowired
    private CondominioService condominioService;
    
    public Espaco create(EspacoResource resource){
        Condominio c = condominioService.getCondominioById(resource.getId_condominio());
        if(c != null){
            Espaco espaco = Espaco.builder().capacidadeMax(resource.getCapacidadeMax())
                    .condominio(c).descricao(resource.getDescricao()).nome(resource.getNome()).build();
            return repository.save(espaco);
        } else return null;
    }

    /*public List<Espaco> listEspacosCond(Condominio c) {
        List<Espaco> espacos = repository.findByCondominio(c);
        if(espacos !=null && espacos.size() != 0){
            return espacos;
        } else return null;
    }

    public void delete(long id){
        repository.deleteById(id);
    }*/
    /*
    @Autowired
    EspacoRepository repository;

    public Espaco create(Espaco espaco){

        return repository.save(espaco);

    }*/

    public Optional<List<Espaco>> listByCondominio (Condominio condominio) {
        List<Espaco> espacos = repository.findAll();
        Optional<List<Espaco>> esCond = Optional.of(espacos.stream().filter(e -> e.getId_condominio() == condominio.getId()).collect(Collectors.toList()));
        return esCond;
    }


}
